class DropWhitelistTokensTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :whitelist_tokens
  end
end
