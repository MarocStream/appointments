angular.module('calendarApp')

.service 'AppointmentTypes', ['restmod', (restmod)->
  restmod.model('/appointment_types').mix('AMSApi')
]
