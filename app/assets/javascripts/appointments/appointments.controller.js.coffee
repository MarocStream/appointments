angular.module('calendarApp')

.controller 'AppointmentsCtrl', ['$modal', '$scope', 'Appointments', 'Closings', 'AppointmentSync', '$rootScope', '$timeout', '$window', '$routeParams', '$route', '$location', ($modal, $scope, Appointments, Closings, AppointmentSync, $rootScope, $timeout, $window, $routeParams, $route, $location)->

  userPromise = $rootScope.user_promise.$asPromise()
  userPromise.then((user)->
    angular.extend $scope.calendarConfig,
      editable: user?.isStaffOrAdmin?()
    console.log "userPromise returned:", user
    $scope.user = user
  , ()-> )
  userPromise.finally ->
    $rootScope.settings_promise.$then ->
      # $rootScope.settings has been created
      $scope.calendarConfig.businessHours.start = $rootScope.settings.openTime if $rootScope.settings.openTime
      $scope.calendarConfig.scrollTime = $rootScope.settings.openTime if $rootScope.settings.openTime
      $scope.calendarConfig.businessHours.end = $rootScope.settings.closeTime if $rootScope.settings.closeTime
      unless $scope.user?.isAdmin()
        $scope.calendarConfig.minTime = $scope.calendarConfig.businessHours.start
        $scope.calendarConfig.maxTime = $scope.calendarConfig.businessHours.end
      if $scope.user?.isStaffOrAdmin()
        $scope.calendarConfig.allDaySlot = true
        $scope.calendarConfig.height = 795
      console.log "Calendar config:", $scope.calendarConfig
      $scope.watch = {start: ($routeParams.start && moment(parseInt($routeParams.start, 10)) || moment()).startOf('week').add(1, 'day'), duration: $routeParams.duration || 5}
      $scope.calendarConfig.defaultDate = $scope.watch.start
      $scope.calendar.fullCalendar($scope.calendarConfig)
      AppointmentSync.watch $scope.watch

  $timeout ->
    $('[data-toggle="tooltip"]').tooltip()

  $scope.editAppointment = (appt, errors)->
    if !appt.id || AppointmentSync.can_access(appt)
      modalInstance = $modal.open
        templateUrl: 'appointments/editor/modal.html'
        controller: 'AppointmentModalController'
        size: 'lg'
        resolve:
          appointment: ()-> appt
          appointmentErrors: ()-> errors

    modalInstance.result.then (appt, reinitializeWatch)->
      appt.$save().$then ->
        $route.reload()
      , (rejected)->
        $scope.editAppointment(appt, rejected.$response.data)
    , (appointment) ->
      if appointment && not (appointment in ['backdrop click', 'escape key press'])
        appointment = Appointments.$buildRaw(_.omit(appointment.$encode(), 'id'))
        $scope.editAppointment(appointment)

  $scope.export = ()->
    modalInstance = $modal.open
      templateUrl: 'appointments/export.html'
      controller: 'ExportController'

  # FullCalendar Configuration
  $scope.calendar = $('#appointment-calendar')
  $scope.calendarConfig =
    height: 752
    editable: false
    header:
      left: 'month agendaWeek agendaDay'
      center: 'title'
      right: 'today prev,next'
    hiddenDays: []
    dayClick: (date, jsEvent, view)->
      correctedDate = moment(date).utc().add((new Date()).getTimezoneOffset(), 'minutes').valueOf()
      allDay = moment(correctedDate).hours() == 0 && moment(correctedDate).minutes() == 0
      if allDay
        $scope.editAppointment Closings.$build(duration: 24, date: new Date(moment(correctedDate).valueOf()), all_day: true)
      else
        $scope.editAppointment Appointments.$build(start: new Date(moment(correctedDate).valueOf()))
    eventClick: (event, jsEvent, view)->
      $scope.editAppointment event.appointment || event.closing
    eventDrop: (event, delta, revertFunc)->
      appointment = event.appointment
      correctedDate = moment(event.start).utc().add((new Date()).getTimezoneOffset(), 'minutes').valueOf()
      appointment.start = new Date(moment(correctedDate).valueOf())
      appointment.$save().$then null, -> revertFunc()
    viewRender: (view, element)->
      console.log view
      switch view.intervalDuration._days
        when 0 # Month
          $scope.watch = {start: view.intervalStart.startOf('month'), duration: 31}
          AppointmentSync.watch $scope.watch
        when 1 # Day
          $scope.watch = {start: view.intervalStart.startOf('day'), duration: 1}
          AppointmentSync.watch $scope.watch
        when 7 # Week
          $scope.watch = {start: view.intervalStart.startOf('week').add(1, 'day'), duration: 5}
          # $location.search({start: $scope.watch.start.valueOf(), duration: Math.random()}) # Angular doesn't work, GREAT!!!
          AppointmentSync.watch $scope.watch
      $window.history.pushState(null, "Appointments", "/?start=#{$scope.watch.start.valueOf()}&duration=#{$scope.watch.duration}")
    aspectRatio: 2
    timezone: 'America/New_York'
    eventLimit: true
    allDaySlot: false
    businessHours:
      start: '09:00:00' # Default, is replaced by settings
      end: '17:00:00'   # Default, is replaced by settings
    slotLabelFormat: 'hh:mma'
    scrollTime: '10:00:00'
    slotDuration: '00:10:00'
    slotLabelInterval: '00:10:00'
    defaultView: 'agendaWeek'
    minTime: '00:00:00'
    maxTime: '24:00:00'
    eventDurationEditable: false
    weekends: false
    eventResize: (event, delta, revertFunc)-> revertFunc()

  AppointmentSync.setup($scope.calendar, $scope.appointment_types)

]
