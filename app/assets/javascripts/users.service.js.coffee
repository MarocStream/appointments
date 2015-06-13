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
  restmod.model('/admin/users').mix('AMSApi').mix
    phones: { hasMany: 'Phone' }
    addresses: { hasMany: 'Address'}
    $extend:
      Model:
        pack: (user, raw)->
          {user: angular.extend(raw, {phones_attributes: user.phones.$wrap(), addresses_attributes: user.addresses.$wrap()})}
]

.service 'Phone', ['restmod', (restmod)->
  restmod.model('/admin/users/:user_id/phones')
]

.service 'Address', ['restmod', (restmod)->
  restmod.model('/admin/users/:user_id/addresses')
]
