require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# TODO: add a basic little map to move around in!

module DarkElfWip02
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Uncomment the following lines if not running on Heroku or using Foreman (or Heroku CLI)
    # config.after_initialize do
    #   $telnetServerPid = spawn("ruby lib/telnet_server.rb")
    # end

    # at_exit do
    #   puts 'Killing telnet server'
    #   Process.kill('QUIT', $telnetServerPid) if $telnetServerPid
    # end

  end
end
