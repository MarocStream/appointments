angular.module('calendarApp')

.controller 'AppointmentModalController',
['$scope', 'appointment', '$modalInstance', 'AppointmentTypes', 'Appointments', 'Users',
($scope,    appointment,   $modalInstance,   AppointmentTypes,   Appointments,   Users)->

  $scope.appointment = appointment || Appointments.$build()
  if $scope.appointment.start
    date = moment($scope.appointment.start)
  else
    date = moment()
  date.subtract(date.minutes() % 10, 'minutes')
  date.seconds(0)
  $scope.appointment.start = new Date(date.valueOf())

  AppointmentTypes.$search().$then (types)->
    $scope.types = types
    $scope.appointment.appointmentTypeId ||= types[0].id
  Users.$find('profile').$then (user)->
    $scope.appointment.user = user
    # $scope.appointment.user_id = user.id

  $scope.ok = ()->
    console.log "Closing appointment with start date of #{$scope.appointment.start}"
    $modalInstance.close($scope.appointment)

  $scope.cancel = ()->
    $modalInstance.dismiss()

  $scope.remove = ()->
    $scope.appointment.$destroy()
    $modalInstance.dismiss(true)

]
