require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Devise i18n japanese
    config.i18n.default_locale = :ja

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Copy the generate key set and set them as environment variables
    config.active_record.encryption.primary_key = '56d0d26033a25f12660df67bf38f3fde7440496e171105c07847b37d67d93a8c95852a2f52b1318e4a1e419c2ad128a5b9371c5bb2b753eaee4be229a0804c6d'
    config.active_record.encryption.deterministic_key = 'bfcdb028a0f91e3db00509dd5ffb5b8d781eaceface26ce9ff3de0a41ceaed6cf56002d5d3e3b95a71a3aaff27a230f294655b9efcacbc0db1ff48bad8a529e9'
    config.active_record.encryption.key_derivation_salt = 'e5d7c6bc5090471aa94f953bd95a9ba7e0f8cc79bb3484ee55542b95adb17e7cd72925e467c30e7b7bd7f7d2300d6c443411af90a27677918f359c730ebba044'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
