class Reservation < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :purchased_item, optional: true

  validates :quantity, presence: true
end
