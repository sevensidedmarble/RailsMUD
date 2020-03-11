namespace :telnet do
  desc 'Launch the Telnet server'
  task :run do
    ruby 'lib/assets/telnet_server.rb'
  end
end
