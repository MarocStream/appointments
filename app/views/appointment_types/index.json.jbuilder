json.appointment_types do
  json.array!(@appointment_types) do |appointment_type|
    json.partial! 'show', appointment_type: appointment_type
    json.url appointment_type_url(appointment_type, format: :json)
  end
end
