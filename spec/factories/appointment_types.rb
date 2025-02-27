# Read about factories at https://github.com/thoughtbot/factory_bot_rails
FactoryBot.define do
  sequence(:color_class){ |n| "color-#{n}"}
end
FactoryBot.define do
  factory :appointment_type do
    name {'Checkup'}
    duration {10}
    prep_duration {5}
    post_duration {3}
    color_class { generate(:color_class) }
  end
  factory :blank_appointment_type, class: AppointmentType do
    name {'Testing'}
    duration {20}
    color_class { generate(:color_class) }
  end
end
