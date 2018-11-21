class AddTimestampsToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :created_at, :datetime, null: false
    add_column :reservations, :updated_at, :datetime, null: false
    add_column :purchased_items, :created_at, :datetime, null: false
    add_column :purchased_items, :updated_at, :datetime, null: false
    add_column :orders, :created_at, :datetime, null: false
    add_column :orders, :updated_at, :datetime, null: false
  end
end
