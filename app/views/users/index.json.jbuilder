json.users @users do |user|
  json.extract! user, :id, :first, :middle, :last, :phone, :dob, :gender, :created_at, :updated_at, :reverse_display, :display, :role, :email, :last_sign_in_at
  json.addresses user.addresses
  json.phones user.phones
  json.url admin_user_url(user, format: :json)
end
