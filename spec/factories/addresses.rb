# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :address do
    street {'123 Some St.'}
    apt {'Apt 456'}
    postcode {'12345'}
    city {'Cityville'}
    state {'ST'}
    country {'USA'}
  end
end
