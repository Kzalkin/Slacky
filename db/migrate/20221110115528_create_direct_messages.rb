class CreateDirectMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :direct_messages do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
