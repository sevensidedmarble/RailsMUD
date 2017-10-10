module PlayerCommandSet
  class LookCommand
    attr_accessor :name, :aliases, :callback

    attr_accessor :keys
    def keys
      @aliases.push(@name)
    end

    def initialize
      @name = 'look'
      @aliases = ['l']
      @callback = lambda { |user, input_string|
        room = current_room
        title = "A dusty plain."
        desc = "It's dusty for miles."
        return [title, desc]
      }
    end
  end
end

class Player < ApplicationRecord
  belongs_to :room, :user

  include UserCommandSet
  @@user_cmdset = [LookCommand.new]

  def current_room
    Room.find(self.room_id)
  end

  def parse_command(input_string)
    # take in a string of input either from web console or telnet,
    # then compare it against all the users command sets to see if it matches
    # if it does, execute the matching commmand and pass in the args
    # if theres no match send a message to ActionCable saying 'I don't understand what you're trying to do!

    words = input_string.split(' ')
    # try to match the first word.
    first_word = words.first.to_s #
    command = @@user_cmdset.find { |cmd| cmd.keys.include?(first_word) }
    if command
      command.callback.call(self, input_string)
    else
      ["I don't understand what you're trying to do!"]
    end
  end

end
