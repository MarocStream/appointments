angular.module('calendarApp')

.controller 'AppointmentsCtrl', ['$modal', '$scope', 'Appointments', 'AppointmentTypes', '$rootScope', ($modal, $scope, Appointments, AppointmentTypes, $rootScope)->

  $scope.appointments = []

  reformAppointment = (appt, existing)->
    type = _.findWhere $scope.types, id: appt.appointmentTypeId
    if !$rootScope.user? || ($rootScope.user.isPatient() && $rootScope.user.id != appt.user?.id)
      type = angular.extend(type, {name: 'Slot Taken', colorClass: 'black', textColor: 'white'})
    existing ||= {title: type.name, color: type.colorClass, textColor: type.textColor, allDay: false, appointment: appt}
    if $rootScope.user? && ($rootScope.user.isStaffOrAdmin() || ($rootScope.user.isPatient() && $rootScope.user.id != appt.user?.id))
      existing.editable = true
    start = moment(appt.start)
    if existing.start
      existing.start.hours(start.hours()).minutes(start.minutes())
    else
      existing.start = start
    existing.end ||= moment(appt.start)
    existing.end.minutes(existing.end.minutes() + type.duration)
    existing

  AppointmentTypes.$search().$then (types)->
    $scope.types = types

    Appointments.$search(start: moment().startOf('week'), duration: 7).$then (appointments)->
      apps = []
      _.each appointments, (a)->
        apps.push reformAppointment(a)

      $scope.appointments.push(apps)

  $scope.editAppointment = (appt)->
    modalInstance = $modal.open
      templateUrl: 'appointments/editor/modal.html'
      controller: 'AppointmentModalController'
      resolve:
        appointment: ()-> appt

    modalInstance.result.then (appt)->
      appt.$save().$then (a)->
        existing = _.findWhere $scope.appointments[0], (p)-> p.appointment.id == a.id
        if existing
          delete existing._id
          reformAppointment(a, existing)
        else
          $scope.appointments[0].push reformAppointment(a)
    , (destroyed)->
      if destroyed
        index = $scope.appointments[0].indexOf(appt)
        $scope.appointments[0].splice(index, 1)

  $scope.calendar =
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

  $rootScope.user_promise.$then (user)->
    angular.extend $scope.calendar,
      editable: user?.isStaffOrAdmin?()

]
