require_relative 'boot'

require 'rails/all'

require 'Mollie/API/Client'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)



# tip van stackoverflow maar lijkt niet echt te werken
# config.serve_static_assets = true


#tip van een site om geen problemen te krijgen met timezones
# config.active_record.default_time_zone = "UTC"

module Musc
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
