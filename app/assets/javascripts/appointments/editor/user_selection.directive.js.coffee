angular.module('calendarApp')

.directive 'userSelection', ['PatientLookup', (PatientLookup)->
  restrict: 'E'
  transclude: true
  scope: {
    appointment: '='
  }
  templateUrl: 'appointments/editor/user_selection.html'
  link: ($scope, $element, $attrs)->
    if $scope.appointment.user?.id || $scope.appointment.userId
      PatientLookup.$find($scope.appointment.user?.id || $scope.appointment.userId).$then (user)->
        $scope.user = user.user

    $scope.user_results = []
    $scope.fetch = (search)->
      PatientLookup.$search({search: search}).$then (results)->
        $scope.user_results = results

    $scope.update = (selected)->
      if selected
        $scope.appointment.userId = selected.id
        $scope.user = selected
]
