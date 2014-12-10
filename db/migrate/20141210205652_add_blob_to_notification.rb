class AddBlobToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :blob, :text
  end
end
