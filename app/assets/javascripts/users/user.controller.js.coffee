angular.module('calendarApp')

.controller 'UserController', ['$scope', '$modalInstance', 'user', 'showEmailPassword', '$timeout', ($scope, $modalInstance, user, showEmailPassword, $timeout)->
  $timeout ->
    $('ng-form[name="userForm"] input[data-date="true"]').datetimepicker({format: 'MM/DD/YYYY'}).on 'dp.change', (e) ->
      $(e.currentTarget).change()

  $scope.user = user
  $scope.showEmailPassword = showEmailPassword

  $scope.user.phones.push $scope.user.phones.$build() if $scope.user.phones.length == 0
  $scope.user.addresses.push $scope.user.addresses.$build() if $scope.user.addresses.length == 0

  $scope.add = (field)->
    $scope.user[field].push $scope.user[field].$build()

  $scope.remove = (field, index)->
    $scope.user[field].splice(index, 1)

  $scope.ok = ()->
    $modalInstance.close($scope.user)

  $scope.cancel = ()->
    $modalInstance.dismiss()
]
