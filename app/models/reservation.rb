class Reservation < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :purchase
end
