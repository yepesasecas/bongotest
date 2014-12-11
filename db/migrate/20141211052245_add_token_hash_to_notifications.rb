class AddTokenHashToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :token_hash, :string
  end
end
