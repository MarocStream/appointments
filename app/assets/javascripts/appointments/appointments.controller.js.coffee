angular.module('calendarApp')

.controller 'AppointmentsCtrl', ['$modal', '$scope', 'Appointments', 'Closings', 'AppointmentTypes', 'AppointmentSync', '$rootScope', '$timeout', '$window', ($modal, $scope, Appointments, Closings, AppointmentTypes, AppointmentSync, $rootScope, $timeout, $window)->

  AppointmentTypes.$search().$then (types)->
    $scope.types = types
    AppointmentSync.setup($scope.calendar, $scope.types)
    userPromise = $rootScope.user_promise.$asPromise()
    userPromise.then((user)->
      angular.extend $scope.calendarConfig,
        editable: user?.isStaffOrAdmin?()
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
        $scope.calendar.fullCalendar($scope.calendarConfig)
        AppointmentSync.watch start: moment().startOf('week').add(1, 'day'), duration: 5

  $scope.editAppointment = (appt, errors)->
    modalInstance = $modal.open
      templateUrl: 'appointments/editor/modal.html'
      controller: 'AppointmentModalController'
      resolve:
        appointment: ()-> appt
        appointmentErrors: ()-> errors

    modalInstance.result.then (appt)->
      appt.$save().$then (-> ), (rejected)->
        $scope.editAppointment(appt, rejected.$response.data)

  $scope.export = ()->
    modalInstance = $modal.open
      templateUrl: 'appointments/export.html'
      controller: 'ExportController'

  # FullCalendar Configuration
  $scope.calendar = $('#appointment-calendar')
  $scope.calendarConfig =
    height: 850
    editable: false
    header:
      left: 'month agendaWeek agendaDay'
      center: 'title'
      right: 'today prev,next'
    hiddenDays: []
    dayClick: (date, jsEvent, view)->
      console.log "Got date #{date}"
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
      switch view.intervalDuration._days
        when 0 # Month
          AppointmentSync.watch start: moment().startOf('month'), duration: 31
        when 1 # Day
          AppointmentSync.watch start: moment().startOf('day'), duration: 1
        when 7 # Week
          AppointmentSync.watch start: moment().startOf('week').add(1, 'day'), duration: 5
    aspectRatio: 2
    timezone: 'America/New_York'
    eventLimit: true
    allDaySlot: false
    businessHours:
      start: '09:00:00' # Default, is replaced by settings
      end: '17:00:00'   # Default, is replaced by settings
    axisFormat: 'h:mma'
    scrollTime: '08:00:00'
    slotDuration: '00:15:01'
    defaultView: 'agendaWeek'
    minTime: '06:00:00'
    maxTime: '20:00:00'
    weekends: false
    eventResize: (event, delta, revertFunc)-> revertFunc()

]
