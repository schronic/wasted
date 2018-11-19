class Item < ApplicationRecord
  has_many :reservations
  validates :name, :price, :quantity, :pickup_time, presence: true
end
