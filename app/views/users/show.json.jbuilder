json.user do
  json.extract! @user, :id, :first, :middle, :last, :dob, :gender, :created_at, :updated_at, :reverse_display, :display, :role, :email, :last_sign_in_at
  json.addresses @user.addresses
  json.phones @user.phones
end
