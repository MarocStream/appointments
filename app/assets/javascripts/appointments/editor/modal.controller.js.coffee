angular.module('calendarApp')

.controller 'AppointmentModalController',
['$scope', '$modalInstance', 'AppointmentTypes', 'Appointments', 'Users',
($scope,    $modalInstance,   AppointmentTypes,   Appointments,   Users)->

  $scope.appointment = Appointments.$build()
  date = new Date()
  date.setMinutes(date.getMinutes() - (date.getMinutes() % 10))
  date.setSeconds(0)
  $scope.appointment.start = date.toJSON()

  AppointmentTypes.$search().$then (types)->
    $scope.types = types
    $scope.appointment.appointmentTypeId = types[0].id
  Users.$find('profile').$then (user)->
    $scope.appointment.user = user

  $scope.ok = ()->
    $modalInstance.close($scope.appointment)

  $scope.cancel = ()->
    $modalInstance.dismiss()

]
