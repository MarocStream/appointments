angular.module('calendarApp')

.controller 'AppointmentModalController',
['$scope', 'appointment', '$modalInstance', 'AppointmentTypes', 'Appointments', 'Users', '$rootScope', '$timeout', '$filter'
( $scope,   appointment,   $modalInstance,   AppointmentTypes,   Appointments,   Users,   $rootScope,   $timeout,   $filter)->

  $timeout ->
    $('.input-group.date input').datetimepicker({format: 'MM/DD/YYYY'})
  , 100

  $scope.setDate = ()->
    if $scope.start || $scope.appointment.start
      date = moment($scope.start || $scope.appointment.start)
    else
      date = moment()

    if $scope.appointment.start
      start = moment($scope.appointment.start)
      date.hours(start.hours())
      date.minutes(start.minutes())
    date.subtract(date.minutes() % 10, 'minutes')
    date.seconds(0)
    $scope.appointment.start = new Date(date.valueOf())
    $scope.start = $filter('date')($scope.appointment.start, 'MM/dd/yyyy')

  $scope.appointment = appointment || Appointments.$build()
  $scope.setDate()

  AppointmentTypes.$search().$then (types)->
    $scope.types = types
    $scope.appointment.appointmentTypeId ||= types[0].id

  if $rootScope.user.isPatient()
    $scope.appointment.userId ||= $rootScope.user?.id

  $scope.ok = ()->
    console.log "Closing appointment with start date of #{$scope.appointment.start}"
    $modalInstance.close($scope.appointment)

  $scope.cancel = ()->
    $modalInstance.dismiss()

  $scope.remove = ()->
    $scope.appointment.$destroy()
    $modalInstance.dismiss()

]
