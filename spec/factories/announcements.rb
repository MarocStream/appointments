# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    name "Some Announcement"
    content "Please listen to this message"
    end_date "01/26/2015 11:02 PM"
  end
end
