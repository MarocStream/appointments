angular.module('calendarApp')

.service 'AppointmentSync', ['$window', '$rootScope', 'Appointments', 'Closings', '$routeParams', ($window, $rootScope, Appointments, Closings, $routeParams)->

  that = @
  @calendar = types = null
  @setup = (cal, tps)=>
    @calendar = cal
    types = tps

  {Socket} = Phoenix
  socket = new Socket("ws://#{$window.__ws_url__ || "#{$window.location.hostname}:#{$window.location.port}"}#{$window.__ws_path__}")
  socket.connect()
  channel = null

  @current_watch = null
  @watch = (options, force = false)=>
    shared = $rootScope.user?.isStaffOrAdmin()
    params = "start=#{JSON.stringify(options.start).slice(1,-1)}&duration=#{options.duration}#{if shared then '' else "&id=#{$rootScope.user?.id || 'unauthorized'}"}"
    new_watch = "proxy://appointments.json?#{params}"
    if @current_watch != new_watch || force
      channel?.leave()
      @current_watch = new_watch
      console.log "Watching", @current_watch
      channel = socket.chan(@current_watch, {session_id: $window.__auth_token__, shared: shared})
      channel.on 'data:update', (data)->
        # Clear everything
        that.cleanupDeleted(that.calendar)
        console.log "Got updated data:", data.appointments
        data.appointments ||= []
        that.appointments = data.appointments
        that.closings = data.closings
        that.renderEvents(that.calendar, that.appointments, that.closings, options.start)
      channel.join()

  @cleanupDeleted = (calendar, appointments, closings) ->
    apptIds = _.map appointments, (a)-> a.id
    closingIds = _.map closings, (c)-> c.id
    calendar.fullCalendar('removeEvents', (e)-> e.appointment?.id not in apptIds && e.closing?.id not in closingIds)

  @renderEvents = (calendar, appointments, closings, calendarStart) ->
    _.each appointments.concat(closings), (a)->
      existing = calendar.fullCalendar('clientEvents', (e)-> e.appointment?.id == a.id || e.closing?.id == a.id)[0]
      that.placeEvent(calendar, existing, a, calendarStart)

  @placeEvent = (calendar, existing, appointment, calendarStart) ->
    if existing && appointment.id != 'new'
      # Update existing
      if appointment.start # appointment
        calAppt = angular.extend(existing, that.reformAppointment(appointment, existing))
      else # closing
        calAppt = angular.extend(existing, that.reformClosing(appointment, existing, calendarStart))
      calendar.fullCalendar 'updateEvent', calAppt
    else
      # Add new
      if appointment.start
        calAppt = that.reformAppointment(appointment)
      else
        calAppt = that.reformClosing(appointment, undefined, calendarStart)
      calendar.fullCalendar('renderEvent', calAppt)

  @reformClosing = (closing, existing, calendarStart)->
    existing ||= {}
    closing = Closings.$buildRaw(closing) unless closing.$pk
    type = {name: "Closed#{if closing.desc then " - #{closing.desc}" else ''}", colorClass: 'black', textColor: 'white'}
    angular.extend(existing, {title: type.name, color: type.colorClass, textColor: type.textColor, allDay: closing.all_day, closing: closing})
    if $rootScope.user?.isStaffOrAdmin()
      existing.editable = true
    existing.start = moment(closing.date)
    if closing.recurring
      newMoment = moment(calendarStart).startOf('week')
      s = existing.start.clone()
      s.year(newMoment.year())
        .month(newMoment.month())
        .date(newMoment.date())
        .add(existing.start.day(), 'days')
      existing.start = s
    existing.end = moment(existing.start).hours(existing.start.hours() + closing.duration)
    existing

  @can_access = (appointment) ->
    $rootScope.user? && ($rootScope.user.isStaffOrAdmin() || ($rootScope.user.isPatient() && $rootScope.user.id == (appointment.userId || appointment.user?.id)))

  @reformAppointment = (appointment, existing) =>
    existing ||= {}
    appointment = Appointments.$buildRaw(appointment) unless appointment.$pk
    type = _.clone(_.findWhere types, id: appointment.appointmentTypeId)
    if !appointment.showType && !@can_access(appointment)
      type = angular.extend(type, {name: 'Slot Taken', colorClass: 'black', textColor: 'white'})
      angular.extend(existing, {title: type.name})
    else
      angular.extend(existing, {title: appointment.user?.display})
    angular.extend(existing, {color: type.colorClass, textColor: type.textColor, allDay: false, appointment: appointment})
    if !appointment.disableEdit && @can_access(appointment)
      existing.editable = true
    start = moment(appointment.start)
    if existing.start
      existing.start.hours(start.hours()).minutes(start.minutes())
    else
      existing.start = start
    existing.end = moment(appointment.endTime)
    existing

  @
]
