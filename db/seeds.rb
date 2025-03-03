# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#unless Rails.env.test?
password = Rails.env.development? ? 'password' : SecureRandom.hex(4)
User.create!(
  first: 'Test',
  middle: 'T',
  last: 'User',
  email: 'test@test.com',
  password: password,
  password_confirmation: password,
  dob: 40.years.ago.to_date.to_s,
  gender: 'male',
  phones_attributes: [
    {country: 1, number: 12345678, kind: 0}
  ],
  addresses_attributes: [
    {street: '123 Some St.', postcode: '12345', city: 'City', state: 'ST', country: 'US'}
  ])
puts "Created test@test.com/#{password} as a patient account."
User.create!(
  first: 'Staff',
  middle: 'E',
  last: 'User',
  email: 'staff@test.com',
  password: password,
  password_confirmation: password,
  role: User.roles[:staff],
  dob: 25.years.ago.to_date.to_s,
  gender: 'female',
  phones_attributes: [
    {country: 1, number: 12345678, kind: 0}
  ],
  addresses_attributes: [
    {street: '123 Some St.', postcode: '12345', city: 'City', state: 'ST', country: 'US'}
  ])
puts "Created staff@test.com/#{password} as a staff account."
User.create!(
  first: 'Admin',
  middle: 'D',
  last: 'User',
  email: 'admin@test.com',
  password: password,
  password_confirmation: password,
  role: User.roles[:admin],
  dob: 30.years.ago.to_date.to_s,
  gender: 'female',
  phones_attributes: [
    {country: '1', number: '12345678', kind: 0}
  ],
  addresses_attributes: [
    {street: '123 Some St.', postcode: '12345', city: 'City', state: 'ST', country: 'US'}
  ])
puts "Created admin@test.com/#{password} as an admin account."

AppointmentType.create!(name: 'Not-Feeling-Well Visit', duration: 30, prep_duration: 5, post_duration: 10, color_class: 'red', text_color: 'white')
AppointmentType.create!(name: 'Short Visit/Follow-Up', duration: 10, prep_duration: 0, post_duration: 0, color_class: 'blue', text_color: 'white')
AppointmentType.create!(name: 'TB Test', duration: 15, prep_duration: 5, post_duration: 0, color_class: 'yellow', text_color: 'black')
AppointmentType.create!(name: 'Travel-Related Visit', duration: 20, prep_duration: 0, post_duration: 5, color_class: 'orange', text_color: 'black')

Setting.create!(name: 'Open Time', desc: 'Enter the opening hour in 24 hour format as in "09:00:00" for 9am.', value: '09:00:00')
Setting.create!(name: 'Close Time', desc: 'Enter the closing hour in 24 hour format as in "17:00:00" for 5pm.', value: '17:00:00')
#end
