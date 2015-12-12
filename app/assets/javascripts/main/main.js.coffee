angular.module('calendarApp')
.config ['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider)->
  $routeProvider
    .when '/',
      templateUrl: 'main.html'
      controller: 'MainCtrl'
      reloadOnSearch: false

  $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest'
]

.factory 'DateParseFilter', ()->
  (value)->
    date = new Date()
    date.setTime(Date.parse(value))
    date
