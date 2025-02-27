require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Appointments
  class Application < Rails::Application

    config.phoenix_url = nil
    config.phoenix_path = '/proxy'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
   config.active_support.to_time_preserves_timezone = :zone
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

   # config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
   config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
   # config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      "<span class='has-error'>#{html_tag}</span>".html_safe
    }

    config.active_job.queue_adapter = :sidekiq

    # This doesnt work...
    # config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    # I18n.default_locale = 'en-US'

    config.to_prepare { Devise::Mailer.layout "mailer" }

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
                   address: 'smtp.gmail.com',
                      port: '587',
                    domain: 'gmail.com',
                 user_name: ENV['email_user_name'],
                  password: ENV['email_password'],
            authentication: 'plain',
      enable_starttls_auto: true
    }

    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default charset: 'utf-8'
    config.action_mailer.default_options = {from: 'no-reply@dev.washingtontravelclinic.com'}
    config.action_mailer.asset_host = "http://localhost:3000/"
  end
end
