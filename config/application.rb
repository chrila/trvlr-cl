# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TimeTravellingTurtle
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.action_mailer.default_url_options = { host: "localhost:3000" }
    config.action_view.form_with_generates_remote_forms = false
  end
end
