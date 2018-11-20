class PurchasedItem < ApplicationRecord
  has_one :reservation, dependent: :destroy
  belongs_to :item
  belongs_to :order, optional: true

  validates :item_purchase_price,
            :item_purchase_name,
            :item_purchase_quantity,
            presence: true
end
