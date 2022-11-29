class AddPrivateToChannels < ActiveRecord::Migration[7.0]
  def change
    add_column :channels, :is_private, :boolean, default: false
  end
end
