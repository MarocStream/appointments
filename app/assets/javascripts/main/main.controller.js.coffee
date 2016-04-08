'use strict';

angular.module('calendarApp')
.controller 'MainCtrl', ['$scope', '$rootScope', 'Users', 'Settings', 'AppointmentTypes', '$filter', ($scope, $rootScope, Users, Settings, AppointmentType, $filter)->

  $rootScope.user_promise = Users.$find('profile')

  $rootScope.settings_promise = Settings.$search()

  $rootScope.appointment_types = _.map $rootScope.appointment_types, (t)-> AppointmentType.$buildRaw(t)

  $rootScope.user_promise.$then (user)->
    $rootScope.user = user
  $rootScope.settings_promise.$then (settings)->
    $rootScope.settings = _.reduce settings, (combined, setting)->
      combined[_.camelize(setting.name)] = setting.value
      combined
    , {}

]
