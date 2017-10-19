require 'action_cable_client'
require 'socket'

puts 'Telnet server process started.'

def actionCableClientStart
  puts "Beginning ActionCableClient connection attempt."
  uri = "ws://127.0.0.1:3000/cable"
  client = ActionCableClient.new(uri, 'WorldChannel', true, {'id' => 1})

  modes = [:getting_email, :getting_password, :main]
  current_mode = :getting_email

  # the connected callback is required, as it triggers
  # the actual subscribing to the channel but it can just be
  # client.connected {}
  client.connected {
    send_data "Enter the email address of the account you'd like to log into"     
  }

  # called whenever a message is received from the server
  client.received do | data |
    case current_mode
      when :getting_email
        # send the email of who we want to log into to the server
      when :getting_password
        #
      when :main
        #
      else
        send_data 'Test'
    end
    send_data data['message']
  end

  client.errored { |msg| puts msg }

  return client
end

module Server

  def post_init
    puts "Received a new connection"
    @client = actionCableClientStart
  end

  def receive_data data
    @client.perform('send_message', data)
  end

end

EventMachine.run do
  EventMachine.start_server '127.0.0.1', 8888, Server

  # puts "Beginning ActionCableClient connection attempt."
  # uri = "ws://127.0.0.1:3000/cable"
  # client = ActionCableClient.new(uri, 'WorldChannel', true, {'id' => 1})
  # # the connected callback is required, as it triggers
  # # the actual subscribing to the channel but it can just be
  # # client.connected {}
  # client.connected { puts 'successfully connected.' }
  #
  # # called whenever a message is received from the server
  # client.received do | message |
  #   puts message
  # end
  #
  # client.errored { |msg| puts msg }
  #
  # # Sends a message to the sever, with the 'action', 'speak'
  # client.perform('send_message', { message: 'hello from amc' })
end

# TODO
# try and add this instead https://github.com/paddor/em-simple_telnet_server
# and send tcp entry to actioncable


# server = TCPServer.new('127.0.0.1', 8888)
# loop do
#   client = server.accept    # Wait for a client to connect
#   client.puts "Hello !"
#   client.puts "Time is #{Time.now}"
#   client.close
# end