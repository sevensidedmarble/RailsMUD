class AddExitsToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :exits, :jsonb
  end
end
