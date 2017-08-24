require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module NewFitclubs
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
config.secret_key_base = 'e237c5e3a6feb17558b2ece8e49797863ee1a641ea2f7e9bb41a48b2af2caf9639e5da78849b630190722b71b062f1bd28f8987bbfa4d9fd7d1684a0459341da'
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: :any
      end
    end
  end
end
