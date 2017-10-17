class CreateActors < ActiveRecord::Migration[5.1]
  def change
    create_table :actors do |t|
      t.string :name
      t.references :room, foreign_key: true
      t.integer :max_hp
      t.integer :hp

      t.timestamps
    end
  end
end
