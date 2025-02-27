# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :phone do
    user_id {1}
    number {12345678}
    country {1}
    kind {0}
    extension {0}
  end
end
