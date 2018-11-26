class Order < ApplicationRecord
  belongs_to :user
  has_many :purchased_items, dependent: :destroy

  validates :amount, presence: true

  monetize :amount_cents

  def order_purchased_items
    purchased_items = []
    self.purchased_items.each do |purchased_item|
      purchased_items << purchased_item.item_purchase_name
    end
    purchased_items.join(', ').chomp('"').reverse.chomp('"').reverse
  end
end
