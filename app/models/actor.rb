class Actor < ApplicationRecord
  belongs_to :room

  # methods
#   move between rooms
#   broadcast messages to players in the rooms
#   get hit
#   hit things

  def move_to_room!(new_room)
    self.update room: new_room
  end

  # Will send a message to all players in a room.
  def send_message_to_room(room, msg)

  end

  # Send a message to all players in this room.
  def send_message_to_current_room(msg)
    players_in_room = Player.find_by_room_id @room_id
    players_in_room.each {|p| p.receive_message(msg)}
  end

  # TODO make a mixin for things that can get hit or attack

  def hit(damage)
    self.update hp: (@hp - damage.amount)
  end

  def attack(thing)
    # HARDCODED
    damage = 5
    thing.hit(Damage.new(:physical, damage))
  end

end
