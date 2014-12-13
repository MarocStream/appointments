angular.module('calendarApp')

.service 'Users', ['restmod', (restmod)->
  restmod.model('/users').mix('AMSApi')
]
