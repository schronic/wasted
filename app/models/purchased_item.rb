class PurchasedItem < ApplicationRecord
  has_one :reservation, dependent: :destroy
  belongs_to :item, optional: true
  belongs_to :order, optional: true

  validates :item_purchase_price,
            :item_purchase_name,
            :item_purchase_quantity,
            presence: true

  monetize :item_purchase_price_cents
end
