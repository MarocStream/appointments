angular.module('calendarApp')

.service 'Settings', ['restmod', (restmod)->
  restmod.model('/settings')#.mix('AMSApi')
]
