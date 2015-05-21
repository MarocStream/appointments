json.array!(@users) do |user|
  json.extract! user, :id, :first, :middle, :last, :phone, :dob, :created_at, :updated_at, :reverse_display, :display, :role, :email, :last_sign_in_at
  json.url admin_user_url(user, format: :json)
end
