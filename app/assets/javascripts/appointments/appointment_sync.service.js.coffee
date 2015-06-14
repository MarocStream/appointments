angular.module('calendarApp')

.service 'AppointmentSync', ['$window', '$rootScope', 'Appointments', 'Closings', ($window, $rootScope, Appointments, Closings)->

  calendar = types = null
  @setup = (cal, tps)=>
    calendar = cal
    types = tps

  {Socket} = Phoenix
  socket = new Socket("ws://#{$window.__ws_url__ || "#{$window.location.hostname}:#{$window.location.port}"}#{$window.__ws_path__}")
  socket.connect()
  channel = null

  @current_watch = null
  @watch = (options)=>
    params = "start=#{JSON.stringify(options.start).slice(1,-1)}&duration=#{options.duration}"
    new_watch = "/appointments.json?#{params}"
    unless @current_watch == new_watch
      channel?.leave()
      @current_watch = new_watch
      console.log "Watching", @current_watch
      channel = socket.chan(@current_watch, $window.__auth_token__)
      channel.on 'data:update', (data)->
        console.log "Got updated data:", data.appointments
        _.each data.appointments.concat(data.closings), (a)->
          existing = calendar.fullCalendar('clientEvents', (e)-> e.appointment?.id == a.id || e.closing?.id == a.id)[0]
          if existing && a.id
            # Update existing
            if a.start # appointment
              calAppt = angular.extend(existing, reformAppointment(a, existing))
            else # closing
              calAppt = angular.extend(existing, reformClosing(a, existing))
            calendar.fullCalendar 'updateEvent', calAppt
          else
            # Add new
            if a.start
              calAppt = reformAppointment(a)
            else
              calAppt = reformClosing(a)
            calendar.fullCalendar('renderEvent', calAppt)
        # Remove deleted
        apptIds = _.map data.appointments, (a)-> a.id
        closingIds = _.map data.closings, (c)-> c.id
        calendar.fullCalendar('removeEvents', (e)-> e.appointment?.id not in apptIds && e.closing?.id not in closingIds)
      channel.join()

  reformClosing = (closing, existing)->
    existing ||= {}
    closing = Closings.$buildRaw(closing) unless closing.$pk
    type = {name: "Closed#{if closing.desc then closing.desc else ''}", colorClass: 'black', textColor: 'white'}
    angular.extend(existing, {title: type.name, color: type.colorClass, textColor: type.textColor, allDay: closing.all_day, closing: closing})
    if $rootScope.user?.isStaffOrAdmin()
      existing.editable = true
    existing.start ||= moment(closing.date)
    existing.end ||= moment(existing.start).minutes(existing.start.minutes() + closing.duration)
    existing

  reformAppointment = (appt, existing)->
    existing ||= {}
    appointment = Appointments.$buildRaw(appt) unless appt.$pk
    type = _.findWhere types, id: appointment.appointmentTypeId
    if !$rootScope.user? || ($rootScope.user.isPatient() && $rootScope.user.id != (appointment.userId || appointment.user?.id))
      type = angular.extend(type, {name: 'Slot Taken', colorClass: 'black', textColor: 'white'})
    angular.extend(existing, {title: type.name, color: type.colorClass, textColor: type.textColor, allDay: false, appointment: appointment})
    if $rootScope.user? && ($rootScope.user.isStaffOrAdmin() || ($rootScope.user.isPatient() && $rootScope.user.id != appointment.user?.id))
      existing.editable = true
    start = moment(appointment.start)
    if existing.start
      existing.start.hours(start.hours()).minutes(start.minutes())
    else
      existing.start = start
    existing.end = moment(appointment.start)
    existing.end.minutes(existing.end.minutes() + type.duration)
    existing

  @
]
