class WorldChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "world_channel"
    stream_from "world_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # val = current_user.parse_command(data['message'])
    # puts val.class
    # ActionCable.server.broadcast "world_channel_#{current_user.id}", { message: val }
    # Echo the command:
    # ActionCable.server.broadcast "world_channel_#{current_user.id}", { user: current_user, message: ">" + data['message'] }
    # Message creation incapsulates the parsing of strings by users, then broadcasts them.

    current_user.parse_command(data['message'])
    # Message.new channel: "world_channel_#{current_user.id}", user: current_user, string: data['message']

    # You can pass in the entire user object doing something like this:
    # ActionCable.server.broadcast "world_channel_#{current_user.id}", { user: current_user, message: data['message'] }
    # but beware this will send the whole user object to the js web client. If you do, it's useable like this:
    # data['user']['email']
    # You could do things differently and create a model instead:
    # Message.create! content: data['message']

    # todo
    # currently doing: make the message class handle the above, and this just make messages.
    # store the last 50 messages for each user in cache for 1 hour
    # make message spawn a job to handle the logic
    # todo

  end
end
