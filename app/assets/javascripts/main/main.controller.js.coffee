'use strict';

angular.module('calendarApp')
.controller 'MainCtrl', ['$scope', '$rootScope', 'Users', ($scope, $rootScope, Users)->

  Users.$find('profile').$then (user)->
    $rootScope.user = user

]
