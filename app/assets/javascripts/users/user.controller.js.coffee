angular.module('calendarApp')

.controller 'UserController', ['$scope', '$modalInstance', 'user', '$timeout', ($scope, $modalInstance, user, $timeout)->
  $timeout ->
    $('ng-form[name="userForm"] .input-group.date input[data-date="true"]').datetimepicker({format: 'MM/DD/YYYY'})

  $scope.user = user

  $scope.user.phones.push $scope.user.phones.$build() if $scope.user.phones.length == 0
  $scope.user.addresses.push $scope.user.addresses.$build() if $scope.user.addresses.length == 0

  $scope.add = (field)->
    $scope.user[field].push {}

  $scope.remove = (field, index)->
    $scope.user[field].splice(index, 1)

  $scope.ok = ()->
    $modalInstance.close($scope.user)

  $scope.cancel = ()->
    $modalInstance.dismiss()
]
