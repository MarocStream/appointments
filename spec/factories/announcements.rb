# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :announcement do
    name {'Some Announcement'}
    content {'Please listen to this message'}
    end_date { DateTime.tomorrow.strftime('%m/%d/%Y %H:%M %p')}
  end
end
