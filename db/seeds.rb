# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(
  first: 'Test',
  middle: 'T',
  last: 'User',
  email: 'test@test.com',
  password: 'password',
  password_confirmation: 'password')
admin.toggle!(:admin)
puts 'Created test@test.com/password as an admin account.'
