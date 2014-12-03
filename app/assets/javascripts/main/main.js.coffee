angular.module('calendarApp')
.config ['$routeProvider', ($routeProvider)->
  $routeProvider
    .when '/',
      templateUrl: 'main.html'
      controller: 'MainCtrl'
]
