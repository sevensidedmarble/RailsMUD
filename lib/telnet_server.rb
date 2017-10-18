require 'action_cable_client'
require 'socket'

puts 'Telnet server process started.'

def actionCableClientStart
  puts "Beginning ActionCableClient connection attempt."
  uri = "ws://127.0.0.1:3000/cable"
  client = ActionCableClient.new(uri, 'WorldChannel', true, {'id' => 1})
  # the connected callback is required, as it triggers
  # the actual subscribing to the channel but it can just be
  # client.connected {}
  client.connected { puts 'successfully connected.' }

  # called whenever a message is received from the server
  client.received do | data |
    # puts data
    send_data data['message']['message']
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
      # send_data "received: #{data}\r\n"
    @client.perform('send_message', { message: data })
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