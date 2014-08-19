class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :status
      t.integer :order_id

      t.timestamps
    end
  end
end
