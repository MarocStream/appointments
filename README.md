Appointments
============

A doctor's office appointment based system for the patients with a administrator backend for the staff.

## Installation

### Run bundler

    bundle install

### Install front-end dependencies

    rake bower:install

### Setup the database

    rake db:setup

You will notice three user accounts are created for you to use. Each user account represents a different type of user. The four types of users are:

 * Anonymous User (not logged in)
 * Patient User (logged in)
   * Login/password: test@test.com/password
 * Staff User (logged in with staff role)
   * Login/password: staff@test.com/password
 * Admin User (logged in with admin role)
   * Login/password: admin@test.com/password

### Running the server

   unicorn_rails

### Visit [http://localhost:8080/](http://localhost:8080)

## Tests

To run the `rails` tests, simply run:

    rspec

Or

    rspec spec/<path_to_file_to_run>

To test the front-end angular application:

Either:

    RAILS_ENV=test bundle exec rake spec:javascript

Or visit the following URL after starting the web server:

    http://localhost:8080/specs
