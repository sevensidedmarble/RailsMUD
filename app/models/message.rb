class Message
  include ActiveModel::Model

  attr_accessor :channel, :string
  validates_presence_of :channel, :string
  # after_create_commit { MessageBroadcastJob.perform_later self }

  def initialize(attributes={})
    super
    # todo make this run in a job
    # return_strings = @user.parse_command(@string)
    msg = @string
    if msg.class == String
      ActionCable.server.broadcast @channel, { message: msg }
    elsif msg.class == Integer
      ActionCable.server.broadcast @channel, { message: msg.to_s }
    else
      msg.each do |line|
        ActionCable.server.broadcast @channel, { message: line }
      end
    end
  end
end
