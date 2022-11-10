class DropDirectMessagesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :direct_messages
  end
end
