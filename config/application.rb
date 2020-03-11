require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsMUD
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # TODO: Unused init method that needs tweaking
    # config.after_initialize do
    #   $telnetServerPid = spawn("ruby lib/telnet_server.rb")
    # end

    # TODO: Unused after block
    # at_exit do
    #   puts 'Killing telnet server'
    #   Process.kill('QUIT', $telnetServerPid) if $telnetServerPid
    # end
  end
end
