angular.module('calendarApp')

.controller 'AppointmentModalController',
['$scope', 'appointment', 'appointmentErrors', '$modalInstance', 'AppointmentTypes', 'Appointments', 'Users', '$rootScope', '$timeout', '$filter'
( $scope,   appointment,   appointmentErrors,   $modalInstance,   AppointmentTypes,   Appointments,   Users,   $rootScope,   $timeout,   $filter)->

  $timeout ->
    $('.input-group.date input').datetimepicker({format: 'MM/DD/YYYY'})
  , 100

  $scope.setDate = (obj, name)->
    if $scope[name] || $scope[obj][name]
      date = moment($scope[name] || $scope[obj][name])
    else
      date = moment()

    if $scope[obj][name]
      start = moment($scope[obj][name])
      date.hours(start.hours())
      date.minutes(start.minutes())
    date.subtract(date.minutes() % 10, 'minutes')
    date.seconds(0)
    $scope[obj][name] = new Date(date.valueOf())
    $scope[name] = $filter('date')($scope[obj][name], 'MM/dd/yyyy')

  $scope.allDayClosing = ->
    $scope.closing.duration = 24
    $scope.closing.date = moment($scope.closing.date).startOf('day')

  $scope.ok = ()->
    console.log "Closing appointment/closing with start date of #{$scope.appointment?.start || $scope.closing.date}"
    $modalInstance.close($scope.appointment || $scope.closing)

  $scope.cancel = ()->
    $modalInstance.dismiss()

  $scope.remove = ()->
    $scope.appointment?.$destroy()
    $scope.closing?.$destroy()
    $modalInstance.dismiss()

  $scope.appointmentErrors = appointmentErrors
  if appointment.date
    $scope.closing = appointment
    $scope.closing.date = moment($scope.closing.date).format('MM/DD/YYYY')
    $scope.allDay = $scope.closing.all_day
    $scope.setDate('closing', 'date')
  else
    $scope.appointment = appointment || Appointments.$build()
    $scope.setDate('appointment', 'start')
    AppointmentTypes.$search().$then (types)->
      $scope.types = types
      $scope.appointment.appointmentTypeId ||= types[0].id

    if $rootScope.user.isPatient()
      $scope.appointment.userId ||= $rootScope.user?.id

]
