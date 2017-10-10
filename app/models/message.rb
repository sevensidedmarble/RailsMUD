class Message
  include ActiveModel::Model

  attr_accessor :channel, :user, :string
  validates_presence_of :channel, :user, :string
  # after_create_commit { MessageBroadcastJob.perform_later self }

  def initialize(attributes={})
    super
    # todo make this run in a job
    return_strings = @user.parse_command(@string)
    return_strings.each do |line|
      ActionCable.server.broadcast @channel, { message: line }
    end
  end
end
