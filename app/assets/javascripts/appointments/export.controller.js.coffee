angular.module('calendarApp')

.controller 'ExportController', ['$scope', '$timeout', '$modalInstance', '$window', ($scope, $timeout, $modalInstance, $window)->
  $timeout ->
    $('.input-group.date input').datetimepicker({format: 'MM/DD/YYYY'})

  $scope.export = {
    start: moment().subtract(1, 'month').format('MM/DD/YYYY')
    duration: 30
    type: 'days'
  }

  $scope.calculateEndDate = ->
    moment($scope.export.start).add($scope.export.duration, $scope.export.type).format('MM/DD/YYYY')

  $scope.ok = ()->
    days = moment.duration(moment($scope.calculateEndDate()).diff(moment($scope.export.start))).asDays()
    $window.location.href = "/appointments.csv?start=#{moment($scope.export.start).toString()}&duration=#{days}"
    $modalInstance.close()

  $scope.cancel = ()->
    $modalInstance.dismiss()
]
