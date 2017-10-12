class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :email
  has_many :players

  def current_player
    Player.find(self.current_player_id)
  end

  def parse_command(input_string)
    current_player.parse_command(input_string)
  end

end