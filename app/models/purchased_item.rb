class PurchasedItem < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :item
  belongs_to :order

  validates :item_purchase_price,
            :item_purchase_name,
            :item_purchase_quantity,
            presence: true
end
