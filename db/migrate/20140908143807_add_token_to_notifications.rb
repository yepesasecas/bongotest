class AddTokenToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :token, :string
  end
end
