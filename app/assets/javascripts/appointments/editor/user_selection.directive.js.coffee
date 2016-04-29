angular.module('calendarApp')

.directive 'userSelection', ['PatientLookup', '$modal', '$timeout', (PatientLookup, $modal, $timeout)->
  restrict: 'E'
  transclude: true
  require: '^ngModel'
  scope: {
    appointment: '=ngModel',
    ngChange: '&'
  }
  templateUrl: 'appointments/editor/user_selection.html'
  link: ($scope, $element, $attrs)->
    if $scope.appointment.user?.id || $scope.appointment.userId
      PatientLookup.$find($scope.appointment.user?.id || $scope.appointment.userId).$then (user)->
        user.dob = moment(user.dob).format("MM/DD/YYYY")
        $scope.user = user

    $scope.user_results = []
    $scope.fetch = (search)->
      PatientLookup.$search({search: search}).$then (results)->
        $scope.user_results = results

    $scope.update = (selected)->
      $scope.appointment.userId = selected?.id
      $scope.appointment.user = $scope.user = selected
      $timeout($scope.ngChange) if $scope.ngChange

    $scope.editUser = (user)->
      modalInstance = $modal.open
        templateUrl: 'users/form.html'
        controller: 'UserController'
        size: 'lg'
        resolve:
          user: ()-> user || PatientLookup.$buildRaw({})
          showEmailPassword: ()-> false

      modalInstance.result.then (user)->
        user.$save().$then (saved_user)->
          $scope.update(saved_user)
        , (reject)->
          user.errors = reject.$response.data
          $scope.editUser(user)

]
