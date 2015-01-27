json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :name, :content, :end_date
  json.url announcement_url(announcement, format: :json)
end
