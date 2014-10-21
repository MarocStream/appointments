'use strict';

angular.module('calendarApp')
  .controller('AppointmentmodalCtrl', function ($scope, $modalInstance, event, Config) {
      'use strict';

      var z = 12;
      $scope.config = Config;
      $scope.event = event;

      $scope.$watch('event.type', function(oldVal, newVal) {
      	if(oldVal !== newVal) {
      		//Calculate 
      		alert($scope.event.type.label);
      	}
      });
      $scope.finish = function() {

      };

      $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
      };

      function folderCallback(object) {
        $modalInstance.close();
      }

  });
