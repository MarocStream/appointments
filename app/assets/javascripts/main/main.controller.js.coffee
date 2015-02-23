'use strict';

angular.module('calendarApp')
.controller 'MainCtrl', ['$scope', '$rootScope', 'Users', ($scope, $rootScope, Users)->

  $rootScope.user_promise = Users.$find('profile')

  $rootScope.user_promise.$then (user)->
    $rootScope.user = user

]
