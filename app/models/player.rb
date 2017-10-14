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
    end

    def run (player, input)
      room = player.current_room
      title = room.title
      desc = room.description
      player.send_message_to_self([title, desc])
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
    end

    def run (player, input)
      arguments = input.split(' ').drop(1).join
      room = player.current_room
      puts room.exits[arguments]
      if (exit_id = room.exits[arguments])
        player.move_to(exit_id)
      else
        player.send_message_to_self("There is no exit there!")
      end
    end

  end

end

class Player < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates_presence_of :name, :room_id, :hp, :xp, :level, :user_id

  @@player_cmds = PlayerCommandSet.new

  def move_to(new_id)
    self.update_attribute(:room_id, new_id)
    self.send_message_to_self('moved to ' + Room.find(new_id).title)
  end

  def current_room
    Room.find(self.room_id)
  end

  def send_message_to_self(msg)
    Message.new channel: "world_channel_#{self.user_id}", string: msg
  end

  def send_message_to_user(user_id, msg)
    Message.new channel: "world_channel_#{user_id}", string: msg
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
      command.run(self, input_string)
    else
      self.send_message_to_self("I don't understand what you're trying to do!")
    end
  end

end


# todo: make it so that instead of passing strings all the way back to message, input just gets passed to the user,
# then passed to the player, then parsed, then the message gets created. (including a 'i didn't understand command).
# this is far superiour because then we can call commands without making a message, like self.Look