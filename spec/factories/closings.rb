# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :closing do
    date {"2015-06-14 01:18:15"}
    all_day {false}
    desc {"MyString"}
  end
end
