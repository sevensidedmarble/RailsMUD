class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.references :room, foreign_key: true
      t.integer :hp
      t.integer :xp
      t.integer :level

      t.timestamps
    end
  end
end
