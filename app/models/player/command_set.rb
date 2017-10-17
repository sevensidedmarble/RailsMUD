class Player
  class CommandSet
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

      # Run Look Command
      def run (player, input)

        # Get title and description of the room
        room = player.current_room
        title = room.title
        desc = room.description

        # Get the actors here
        # actors = Actor.where room_id: self.room_id
        actors = Actor.where room_id: 1
        actors_string = actors.map { |a| "A " + a.name + " is here.\n" }

        player.send_message_to_self([title, desc, actors_string])
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
end