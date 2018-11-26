class Order < ApplicationRecord
  belongs_to :user
  has_many :purchased_items, dependent: :destroy

  validates :amount, presence: true

  monetize :amount_cents
end
