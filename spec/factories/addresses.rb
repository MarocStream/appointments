# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street "MyString"
    apt "MyString"
    postcode "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
  end
end
