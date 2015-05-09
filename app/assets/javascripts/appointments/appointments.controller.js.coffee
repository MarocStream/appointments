angular.module('calendarApp')

.controller 'AppointmentsCtrl', ['$modal', '$scope', 'Appointments', 'AppointmentTypes', '$rootScope', '$timeout', ($modal, $scope, Appointments, AppointmentTypes, $rootScope, $timeout)->

  reformAppointment = (appt, existing)->
    existing ||= {}
    type = _.findWhere $scope.types, id: appt.appointmentTypeId
    if !$rootScope.user? || ($rootScope.user.isPatient() && $rootScope.user.id != appt.user?.id)
      type = angular.extend(type, {name: 'Slot Taken', colorClass: 'black', textColor: 'white'})
    angular.extend(existing, {title: type.name, color: type.colorClass, textColor: type.textColor, allDay: false, appointment: appt})
    if $rootScope.user? && ($rootScope.user.isStaffOrAdmin() || ($rootScope.user.isPatient() && $rootScope.user.id != appt.user?.id))
      existing.editable = true
    start = moment(appt.start)
    if existing.start
      existing.start.hours(start.hours()).minutes(start.minutes())
    else
      existing.start = start
    existing.end = moment(appt.start)
    existing.end.minutes(existing.end.minutes() + type.duration)
    existing

  AppointmentTypes.$search().$then (types)->
    $scope.types = types

    Appointments.$search(start: moment().startOf('week'), duration: 7).$then (appointments)->
      apps = []
      _.each appointments, (a)->
        apps.push reformAppointment(a)

      $scope.calendar.fullCalendar('addEventSource', apps)

  $scope.editAppointment = (appt)->
    modalInstance = $modal.open
      templateUrl: 'appointments/editor/modal.html'
      controller: 'AppointmentModalController'
      resolve:
        appointment: ()-> appt

    modalInstance.result.then (appt)->
      appt.$save().$then (a)->
        existing = $scope.calendar.fullCalendar('clientEvents', (e)-> e.appointment.id == a.id)[0]
        if existing && a.id
          calAppt = angular.extend(existing, reformAppointment(a, existing))
          $scope.calendar.fullCalendar 'updateEvent', calAppt
        else
          calAppt = reformAppointment(a)
          $scope.calendar.fullCalendar('renderEvent', calAppt)
    , (destroyed)->
      if destroyed
        $scope.calendar.fullCalendar 'removeEvents', (e)-> e.appointment.id == appt.id

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
      $scope.editAppointment Appointments.$build(start: new Date(moment(correctedDate).valueOf()))
    eventClick: (event, jsEvent, view)->
      $scope.editAppointment event.appointment
    eventDrop: (event, delta, revertFunc)->
      appointment = event.appointment
      correctedDate = moment(event.start).utc().add((new Date()).getTimezoneOffset(), 'minutes').valueOf()
      appointment.start = new Date(moment(correctedDate).valueOf())
      appointment.$save().$then null, -> revertFunc()
    aspectRatio: 2
    timezone: 'America/New_York'
    eventLimit: true
    allDaySlot: false
    businessHours:
      start: '09:00:00'
      end: '17:00:00'
    axisFormat: 'h:mma'
    scrollTime: '08:00:00'
    slotDuration: '00:15:01'
    defaultView: 'agendaWeek'
    minTime: '06:00:00'
    maxTime: '20:00:00'
    weekends: false
    eventResize: (event, delta, revertFunc)-> revertFunc()


  $rootScope.user_promise.$then (user)->
    angular.extend $scope.calendarConfig,
      editable: user?.isStaffOrAdmin?()
    $scope.calendar.fullCalendar($scope.calendarConfig)

]
