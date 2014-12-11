class ChangeOrderIdInNotifications < ActiveRecord::Migration
  def change
    change_column :notifications, :order_id, :string
  end
end
