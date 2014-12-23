json.appointments do
  json.array!(@appointments) do |appointment|
    json.extract! appointment, :id, :user, :start, :appointment_type_id
    # json.end appointment.start + appointment.appointment_type.duration
    # json.title appointment.appointment_type.name
    # json.color appointment.appointment_type.color_class
    # json.text_color appointment.appointment_type.text_color
    # json.all_day false
    # json.url appointment_url(appointment, format: :json)
  end
end
