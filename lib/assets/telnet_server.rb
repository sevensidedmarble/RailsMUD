require 'action_cable_client'
require 'socket'

# This class implements all the methods we need to pass to EventMachine
module TelnetServer
  URI = 'ws://127.0.0.1:3000/cable'.freeze

  def post_init
    puts 'Telnet server loading...'
    @modes = %i[getting_email getting_password main]
    @current_mode = :getting_email
    @email = nil
    @password = nil
    puts 'Received a new connection attempt.'
    send_data "Welcome!\nEnter the email address of the account you'd like to log into.\n"
  end

  def receive_data(data)
    case @current_mode
    when :getting_email
      @email = data
      puts @email
      @current_mode = :getting_password
      send_data "Enter your password.\n"
    when :getting_password
      @password = data
      puts @password.chars.map { |_| '*' }
      @client = client_start @email, @password
      @current_mode = :main
    when :main
      @client.perform('send_message', data)
    else
      send_data 'Something went very weird. @current_mode became undefined.'
      raise 'Receive_data problem...'
    end
  end

  def client_start(email, password)
    puts 'Beginning ActionCableClient connection attempt.'
    client = ActionCableClient.new(
      URI,
      { 'channel' => 'WorldChannel', 'email' => email, 'password' => password },
      true
    )

    client.tap do |c|
      # This callback is required, as it triggers the actual subscribing to the
      # channel but it can just be client.connected {}
      c.connected do
        send_data 'Connection successful! Welcome to RailsMUD!'
      end

      # Called whenever a message is received from the server
      c.received do |data|
        send_data data['message']
      end

      c.errored do |msg|
        puts msg
      end
    end
  end
end

EventMachine.run do
  EventMachine.start_server '127.0.0.1', 8888, TelnetServer
end

# TODO: We could try and add this instead https://github.com/paddor/em-simple_telnet_server
# and send tcp entry to Action Cable like:
# server = TCPServer.new('127.0.0.1', 8888)
# loop do
#   client = server.accept    # Wait for a client to connect
#   client.puts "Hello !"
#   client.puts "Time is #{Time.now}"
#   client.close
# end
