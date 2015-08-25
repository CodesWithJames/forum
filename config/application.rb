require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Forum
  class Application < Rails::Application
    config.time_zone = 'Brasilia'
    config.i18n.default_locale = "pt-br"
    config.filter_parameters += [:password]
    config.encoding = "utf-8"
    config.assets.enabled = true
    config.serve_static_files = true

   config.assets.precompile += %w(topics/view.js.coffee) 
  end
end
