angular.module('calendarApp')
.config ['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider)->
  $routeProvider
    .when '/',
      templateUrl: 'main.html'
      controller: 'MainCtrl'
  $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest'
]

.factory 'DateParseFilter', ()->
  (value)->
    date = new Date()
    date.setTime(Date.parse(value))
    console.log "Parsing #{value} into date: #{date}"
    date
