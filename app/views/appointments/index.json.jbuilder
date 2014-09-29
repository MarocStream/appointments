json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :user_id, :start, :appointment_type_id
  json.url appointment_url(appointment, format: :json)
end
