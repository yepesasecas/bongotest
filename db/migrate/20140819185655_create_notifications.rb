class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string  :status
      t.integer :order_id
      t.text    :order, limit: false
      t.string  :partner_key
      t.timestamps
    end
  end
end
