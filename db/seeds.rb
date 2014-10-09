# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless Rails.env.test?
  User.create!(
    first: 'Test',
    middle: 'T',
    last: 'User',
    email: 'test@test.com',
    password: 'password',
    password_confirmation: 'password')
  puts 'Created test@test.com/password as a patient account.'
  User.create!(
    first: 'Staff',
    middle: 'E',
    last: 'User',
    email: 'staff@test.com',
    password: 'password',
    password_confirmation: 'password',
    role: User.roles[:staff])
  puts 'Created staff@test.com/password as a staff account.'
  User.create!(
    first: 'Admin',
    middle: 'D',
    last: 'User',
    email: 'admin@test.com',
    password: 'password',
    password_confirmation: 'password',
    role: User.roles[:admin])
  puts 'Created admin@test.com/password as an admin account.'
  
  AppointmentType.create!(name: 'Not-Feeling-Well Visit', duration: 30, prep_duration: 5, post_duration: 10, color_class: 'red')
  AppointmentType.create!(name: 'Short Visit/Follow-Up', duration: 10, prep_duration: 0, post_duration: 0, color_class: 'blue')
  AppointmentType.create!(name: 'TB Test', duration: 15, prep_duration: 5, post_duration: 0, color_class: 'yellow')
  AppointmentType.create!(name: 'Trqvel-Related Visit', duration: 20, prep_duration: 0, post_duration: 5, color_class: 'orange')
end
