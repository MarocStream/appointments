# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :appointment do
    start "2014-09-28 13:42:36"
    association :user, factory: :user
    association :appointment_type, factory: :appointment_type
  end
end
