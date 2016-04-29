angular.module('calendarApp')

.controller 'AppointmentModalController',
['$scope', 'appointment', 'appointmentErrors', '$modalInstance', '$modal', 'Appointments', 'Users', '$rootScope', '$timeout', '$filter', 'AppointmentSync',
( $scope,   appointment,   appointmentErrors,   $modalInstance,   $modal,   Appointments,   Users,   $rootScope,   $timeout,   $filter,    AppointmentSync)->

  $timeout ->
    $('.input-group.date input').datetimepicker({format: 'MM/DD/YYYY'}).on 'dp.change', (e) ->
      $(e.currentTarget).change()
  , 100

  $scope.setDate = (obj, name)->
    $timeout ->
      if $scope[name] || $scope[obj][name]
        if $scope[name]
          date = moment($scope[name], 'MM/DD/YYYY')
        else
          date = moment($scope[obj][name])
      else
        date = moment()

      if $scope[obj][name]
        start = moment($scope[obj][name])
        date.hours(start.hours())
        date.minutes(start.minutes())
      date.subtract(date.minutes() % 10, 'minutes')
      date.seconds(0)
      $scope[obj][name] = new Date(date.valueOf())
      $scope[name] = $('[data-date=true]').val() || date.format('MM/DD/YYYY') # WTF angular, update stuff
      merge_date_time()
      $scope.$apply()
      renderCalendar()

  merge_date_time = ->
    time = moment($scope.appointment?.start || $scope.closing.date)
    console.log time
    date = moment($scope.start || $scope.date)
    console.log date
    date.hours(time.hours())
    date.minutes(time.minutes())
    date = new Date(date.utc().valueOf())
    if $scope.appointment
      $scope.appointment.start = date
    else
      $scope.closing.date = date

  $scope.allDayClosing = ->
    if $scope.closing.all_day
      $scope.closing.duration = 24
      $scope.closing.date = moment($scope.closing.date).startOf('day')

  $scope.newUser = (user) ->
    modalInstance = $modal.open
      templateUrl: 'users/form.html'
      controller: 'UserController'
      resolve:
        user: ()-> user || Users.$buildRaw({})
        showEmailPassword: ()-> true

    modalInstance.result.then (user)->
      console.log "modal returned user", user
      user.$save().$then (saved_user)->
        $rootScope.user = saved_user
        $scope.appointment.userId = saved_user.id
        $scope.appointment.user = saved_user
        $scope.reinitializeWatch = true
      , (reject)->
        console.log arguments
        $scope.newUser(reject)

  $scope.ok = ()->
    if $scope.appointment && $scope.appointment.id == 'new'
      delete $scope.appointment.id
      delete $scope.appointment.showType
    else if $scope.closing?.id == 'new'
      delete $scope.closing.id
    console.log "Closing appointment/closing with start date of #{$scope.appointment?.start || $scope.closing.date}"
    $modalInstance.close($scope.appointment || $scope.closing, $scope.reinitializeWatch)

  $scope.cancel = ()->
    $modalInstance.dismiss()

  $scope.newFromExisting = (appointment) ->
    $modalInstance.dismiss(appointment)

  $scope.editable = () ->
    date = $scope.appointment?.start || $scope.closing?.date
    moment(date).isAfter(moment())

  $scope.remove = ()->
    $scope.appointment?.$destroy()
    $scope.closing?.$destroy()
    $modalInstance.dismiss()

  $scope.type_changed = ->
    renderCalendar()

  $scope.type_for = (id)->
    _.findWhere $scope.appointment_types, id: id

  $scope.login = (email, password)->
    $timeout ->
      params = {email: email, password: password}
      console.log params, $scope
      $.ajax
        url: '/users/sign_in'
        contentType: 'application/json'
        method: 'POST'
        data: JSON.stringify({session: params})
        dataType: 'json'
        complete: (xhr, status) ->
          if status != 'error' # really jquery?
            console.log "success", xhr, status
        error: (xhr, status, error) ->
          $scope.login_failure = "Invalid email or password"
          $scope.$apply()

  $scope.add_member = ->
    $scope.appointment.groupMembersAttributes.push({})
    $timeout ->
      $('input[data-date="true"]').datetimepicker({format: 'MM/DD/YYYY'})
    , 100

  $scope.update = ->
    renderCalendar()

  calendarInitialized = false
  renderCalendar = ->
    if calendarInitialized
      appointments = AppointmentSync.appointments
      closings = AppointmentSync.closings
      if $scope.closing
        closings = appointments.concat([$scope.closing])

      render = ->
        console.log "rendering", appointments
        AppointmentSync.cleanupDeleted($scope.calendar)
        AppointmentSync.renderEvents($scope.calendar, appointments, closings)

      if $scope.appointment
        $scope.appointment.showType = true
        $scope.appointment.disableEdit = true
        group_member_count = _.filter($scope.appointment.groupMembersAttributes, (g) -> !g._destroy).length
        Appointments.$find('stage', {start: $scope.appointment.start, appointment_type_id: $scope.appointment.appointmentTypeId, group_members: group_member_count}).$then (appt) ->
          $scope.appointment.start = appt.start
          $scope.appointment.endTime = appt.endTime
          appointments = _.filter(appointments, (a)-> a.id != $scope.appointment.id).concat([$scope.appointment])
          render()
      else
        render()

  $scope.appointmentErrors = appointmentErrors
  if appointment?.date
    $scope.closing = appointment
    $scope.closing.id ||= 'new'
    $scope.allDay = $scope.closing.all_day
    $scope.setDate('closing', 'date')
  else
    $scope.appointment = appointment || Appointments.$build()
    $scope.start = moment(appointment.start).format('MM/DD/YYYY')
    $scope.setDate('appointment', 'start')
    $scope.appointment.id ||= 'new'
    $scope.appointment.appointmentTypeId ||= $scope.appointment_types[0].id
    $scope.appointment.groupMembersAttributes ||= []

    if $rootScope.user?.isPatient()
      $scope.appointment.userId ||= $rootScope.user?.id

  $timeout ->
    $scope.calendar = $('#preview-calendar')
    $scope.calendarConfig =
      height: 300
      editable: false
      header:
        left: ''
        center: 'today prev,next'
        right: ''
      defaultDate: moment($scope.closing?.date || $scope.appointment?.start)
      timezone: 'America/New_York'
      allDaySlot: false
      businessHours:
        start: '09:00:00' # Default, is replaced by settings
        end: '17:00:00'   # Default, is replaced by settings
      slotLabelFormat: 'hh:mma'
      scrollTime: moment($scope.closing?.date || $scope.appointment?.start).add(-30, 'minutes').format('HH:mm:00')
      slotDuration: '00:10:00'
      slotLabelInterval: '00:10:00'
      defaultView: 'agendaDay'
      minTime: '00:00:00'
      maxTime: '24:00:00'
      weekends: false
      eventDurationEditable: false
      viewRender: (view, element)->
        renderCalendar()
      eventResize: (event, delta, revertFunc)-> revertFunc()

    $scope.calendarConfig.businessHours.start = $rootScope.settings.openTime if $rootScope.settings.openTime
    $scope.calendarConfig.scrollTime = $rootScope.settings.openTime if $rootScope.settings.openTime
    $scope.calendarConfig.businessHours.end = $rootScope.settings.closeTime if $rootScope.settings.closeTime
    unless $scope.user?.isAdmin()
      $scope.calendarConfig.minTime = $scope.calendarConfig.businessHours.start
      $scope.calendarConfig.maxTime = $scope.calendarConfig.businessHours.end

    $scope.calendar.fullCalendar($scope.calendarConfig)
    calendarInitialized = true
    renderCalendar()

]
