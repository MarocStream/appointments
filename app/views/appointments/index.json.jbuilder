json.appointments do
  json.array!(@appointments) do |appointment|
    json.extract! appointment, :id, :start, :end_time, :appointment_type_id
    json.group_members_attributes appointment.group_members
    json.user do
      json.extract! appointment.user, :id, :display if appointment.user
    end
    # json.end appointment.start + appointment.appointment_type.duration
    # json.title appointment.appointment_type.name
    # json.color appointment.appointment_type.color_class
    # json.text_color appointment.appointment_type.text_color
    # json.all_day false
    # json.url appointment_url(appointment, format: :json)
  end
end
json.closings do
  json.array!(@closings) do |closing|
    json.extract! closing, :id, :date, :all_day, :desc, :duration
  end
end
