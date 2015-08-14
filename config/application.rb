require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pandora
  class Application < Rails::Application
    config.assets.precompile += ['welcome.css']
    config.assets.precompile += ['utilities/bootstrap.min.css']
    config.assets.precompile += ['utilities/font-awesome.min.css']
    config.assets.precompile += ['elements/navbar.css']
    config.assets.precompile += ['helpers.css']
    config.assets.precompile += ['home.css']
    config.assets.precompile += ['pages/tutorial.css']
    config.assets.precompile += ['tutorial.js']
    config.assets.precompile += ['jquery.min.js']
    config.assets.precompile += ['payment.css']
    config.assets.precompile += ['payment.js']
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
end
