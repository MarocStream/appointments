angular.module 'calendarApp', [
  'templates',
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.bootstrap',
  'ngRoute',
  # 'btford.socket-io',
  'restmod',
  'ui.calendar'
]
.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider)->
  $routeProvider
    .otherwise
      redirectTo: '/'

  $locationProvider.html5Mode(true);
]
