require File.expand_path('../boot', __FILE__)

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Pulsar 
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end

	Application.configure do 

	  ActionMailer::Base.delivery_method = :smtp
	  host = "pulsar-encode.herokuapp.com"
	  ActionMailer::Base.smtp_settings = { 
	    port: ENV['MAILGUN_SMTP_PORT'],
	    address: ENV['MAILGUN_SMTP_SERVER'],
	    user_name: ENV['MAILGUN_SMTP_LOGIN'],
	    password: ENV['MAILGUN_SMTP_PASSWORD'],
	    domain: host,
	    authentication: :plain,
	  }
	  config.action_mailer.default_url_options = { 
	  host: host
	  }
	end
end
