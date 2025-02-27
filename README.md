Appointments
============

[![Build Status](https://semaphoreci.com/api/v1/projects/22489980-0844-4a8f-ad9a-5ecd5ad12335/458396/badge.svg)](https://semaphoreci.com/mgwidmann/appointments)

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

# Deployment

Create a user to run everything (i.e. `web`).

Use `ssh-copy-id` (install via Homebrew) to setup passwordless SSH key login.

Install dependencies:

```
sudo apt-get install nodejs-legacy npm redis-server nginx mysql-server git libmysqlclient-dev
sudo apt-get install esl-erlang=1:17.5.3
sudo apt-get install elixir=1.1.1-2
```

Run the following (don't forget to fill in `<ENVIRONMENT>` with `staging`/`production` etc.):

```
sudo visudo -f /etc/sudoers.d/nginx-overrides
```

Paste the following content:
```
web ALL = (root) NOPASSWD: /etc/init.d/nginx restart
web ALL = (root) NOPASSWD: /etc/init.d/nginx reload
web ALL = (root) NOPASSWD: /bin/mv /tmp/appointments_<ENVIRONMENT> /etc/nginx/sites-available
web ALL = (root) NOPASSWD: /bin/ln -fs /etc/nginx/sites-available/appointments_<ENVIRONMENT> /etc/nginx/sites-enabled/appointments_<ENVIRONMENT>
```

```
sudo visudo -f /etc/sudoers.d/unicorn-overrides
```

```
web ALL = (root) NOPASSWD: /bin/mv /tmp/unicorn_appointments_<ENVIRONMENT> /etc/init.d
web ALL = (root) NOPASSWD: /usr/sbin/update-rc.d -f unicorn_appointments_<ENVIRONMENT> defaults
web ALL = (root) NOPASSWD: /usr/sbin/service unicorn_appointments_production start
web ALL = (root) NOPASSWD: /usr/sbin/service unicorn_appointments_production restart
web ALL = (root) NOPASSWD: /usr/sbin/service unicorn_appointments_production stop
```

Then setup the server with capistrano

```
cap <ENVIRONMENT> setup
```

for jasmine npn replacement 
npm install --save-dev jasmine
