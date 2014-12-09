json.appointments do
  json.array!(@appointments) do |appointment|
    json.extract! appointment, :id, :user, :start, :appointment_type_id
    json.url appointment_url(appointment, format: :json)
  end
end
