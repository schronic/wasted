class AddMonetizeToPurchasedItems < ActiveRecord::Migration[5.2]
  def change
    add_monetize :purchased_items, :item_purchase_price, currency: { present: false }
  end
end
