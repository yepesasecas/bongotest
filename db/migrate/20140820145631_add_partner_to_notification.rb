class AddPartnerToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :partner_key, :string
    add_column :notifications, :order, :string
  end
end
