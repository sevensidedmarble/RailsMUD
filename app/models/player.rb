class PlayerCommandSet
  attr_accessor :cmds

  def initialize
    @cmds = [LookCommand.new, MoveCommand.new]
  end

  class LookCommand
    attr_accessor :name, :aliases, :callback

    attr_accessor :keys
    def keys
      @aliases.push(@name)
    end

    def initialize
      @is_command = true
      @name = 'look'
      @aliases = ['l']
      @callback = lambda { |player, input_string|
        room = player.current_room
        title = room.title
        desc = room.description
        return [title, desc]
      }
    end
  end

  class MoveCommand
    attr_accessor :name, :aliases, :callback

    attr_accessor :keys
    def keys
      @aliases.push(@name)
    end

    def initialize
      @is_command = true
      @name = 'move'
      @aliases = ['m']
      @callback = lambda { |player, input_string|
        arguments = input_string.split(' ').drop(1)
        room = player.current_room
        # return room.exits[arguments.join]
        if (exit_id = room.exits[arguments])
          self.move_to(exit_id)
        else
          "There is no exit there!"
        end
        # case arguments.first
        #   when 'east'
        #     # if there is an exit to the east
        #     # then go east
        #     # else return 'no exit there'
        # end
        # return []
      }
    end

  end

end

class Player < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates_presence_of :name, :room_id, :hp, :xp, :level, :user_id

  @@player_cmds = PlayerCommandSet.new

  def move_to(room_id)
    self.room_id = room_id
    puts 'moved to ' + Room.find(room_id).title
  end

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
    command = @@player_cmds.cmds.find { |cmd| cmd.keys.include?(first_word) }
    if command
      command.callback.call(self, input_string)
    else
      "I don't understand what you're trying to do!"
    end
  end

end


# todo: make it so that instead of passing strings all the way back to message, input just gets passed to the user,
# then passed to the player, then parsed, then the message gets created. (including a 'i didn't understand command).
# this is far superiour because then we can call commands without making a message, like self.Look