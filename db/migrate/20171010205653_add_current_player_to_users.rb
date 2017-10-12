class AddCurrentPlayerToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :current_player, foreign_key: {to_table: :players}
  end
end
