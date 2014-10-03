FactoryGirl.define do
  factory :user do
    first "John"
    last  "Doe"
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  # This will use the User class (Staff would have been guessed)
  factory :staff, class: User do
    first "Staff"
    last  "User"
    sequence(:email){|n| "staff#{n}@example.com" }
    role User.roles[:staff]
    password 'password'
    password_confirmation 'password'
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    first "Admin"
    last  "User"
    sequence(:email){|n| "admin#{n}@example.com" }
    role User.roles[:admin]
    password 'password'
    password_confirmation 'password'
  end
end
