class Order < ApplicationRecord
  belongs_to :user
  has_many :purchased_items, dependent: :destroy
  monetize :amount_cents

  validates :total_price, presence: true
end
