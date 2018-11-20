class AddStateToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :state, :string
    add_column :orders, :item_sku, :string
    add_monetize :orders, :amount
    add_column :orders, :payment, :jsonb
  end
end
