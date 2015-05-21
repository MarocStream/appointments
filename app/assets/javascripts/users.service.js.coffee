angular.module('calendarApp')

.service 'Users', ['restmod', (restmod)->
  restmod.model('/users').mix('AMSApi').mix
    $extend:
      Record:
        isPatient: ->
          @role == null || @role == "patient"
        isStaffOrAdmin: ->
          @role == "staff" || @role == "admin"
]

.service 'PatientLookup', ['restmod', (restmod)->
  restmod.model('/admin/users')
]
