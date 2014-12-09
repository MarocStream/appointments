json.appointment_types do
  json.array!(@appointment_types) do |appointment_type|
    json.extract! appointment_type, :id, :name, :duration, :prep_duration, :post_duration, :color_class, :text_color
    json.url appointment_type_url(appointment_type, format: :json)
  end
end
