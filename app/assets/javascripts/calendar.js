'use strict';

angular.module('calendarApp', [
  'templates',
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.bootstrap',
  'ngRoute',
  // 'btford.socket-io',
  'ui.calendar'
])
  .config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
    $routeProvider
      .otherwise({
        redirectTo: '/'
      });

    $locationProvider.html5Mode(true);
  }])
  .constant('Config', {
    appointmentTypes: [{
      label: 'Twenty',
      time: 20
    },{
      label: 'Ten',
      time: 10
    }]
  });
