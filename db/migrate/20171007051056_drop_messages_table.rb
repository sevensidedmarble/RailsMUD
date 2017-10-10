class DropMessagesTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :messages
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
