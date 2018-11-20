class CreatePurchasedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_items do |t|
      t.integer     :item_purchase_price
      t.integer     :item_purchase_quantity
      t.string      :item_purchase_name
      t.text        :item_purchase_description
      t.datetime    :item_purchase_expiration
      t.datetime    :item_purchase_pickup_time
      t.string      :item_purchase_picture
      t.references  :item, foreign_key: true
      t.references  :order, foreign_key: true
    end
  end
end
