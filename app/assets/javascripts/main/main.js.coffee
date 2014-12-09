angular.module('calendarApp')
.config ['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider)->
  $routeProvider
    .when '/',
      templateUrl: 'main.html'
      controller: 'MainCtrl'
  $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest'
]
