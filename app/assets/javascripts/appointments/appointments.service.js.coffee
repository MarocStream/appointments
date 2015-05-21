angular.module('calendarApp')

.service 'Appointments', ['restmod', (restmod)->
  restmod.model('/appointments').mix('AMSApi').mix('DirtyModel').mix
    start: { decode: 'DateParse' }
    # appointmentType: { belongsTo: 'AppointmentTypes', key: 'appointmentType.id' }
    # user: { belongsTo: 'Users' }
    allDay: { init: false, mask: true }
    # title: { map: 'appointment_type.name' }
    # color: { map: 'appointment_type.color_class' }
    # textColor: { map: 'appointment_type.text_color' }
]
