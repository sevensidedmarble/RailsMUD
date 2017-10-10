class Room < ApplicationRecord
  # has_many :actors_here, foreign_key: "room_id", class_name: "Actor"
  has_many :players_here, foreign_key: "room_id", class_name: "Player"
  # has_many :objects_here, foreign_key: "room_id", class_name: "Object"

end
