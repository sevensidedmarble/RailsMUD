# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# After initializing Rails, start the Dark Elf telnet server
# path_to_telnet_server = Rails.root.to_s + '/Lib/telnet_server.rb'
# spawn("ruby " + path_to_telnet_server)
# puts "ruby " + path_to_telnet_server