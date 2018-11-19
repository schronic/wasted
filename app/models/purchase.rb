class Purchase < ApplicationRecord
  has_many :reservations

  validates :total_price, presence: true
end
