class Order < ApplicationRecord
  belongs_to :user
  has_many :purchased_items, dependent: :destroy

  validates :purchased_items, :total_price, presence: true
end
