require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShelfApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ja
    
    config.time_zone = 'Tokyo'
    
  end
end

config.generators do |generator|
  generator.test_framework :rspec,
                   fixtures: true,
           controller_specs: true,
               helper_specs: false,
              routing_specs: false
  generator.fixture_replacement :factory_bot, dir: "spec/factories"
end

