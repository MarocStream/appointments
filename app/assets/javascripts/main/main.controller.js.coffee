'use strict';

angular.module('calendarApp')
.controller 'MainCtrl', ['$scope', '$rootScope', 'Users', 'Settings', '$filter', ($scope, $rootScope, Users, Settings, $filter)->

  $rootScope.user_promise = Users.$find('profile')

  $rootScope.settings_promise = Settings.$search()

  $rootScope.user_promise.$then (user)->
    $rootScope.user = user
  $rootScope.settings_promise.$then (settings)->
    $rootScope.settings = _.reduce settings, (combined, setting)->
      combined[_.camelCase(setting.name)] = setting.value
      combined
    , {}

]
