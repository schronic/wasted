class Item < ApplicationRecord
  has_many :reservations
  validates :name, :price, :quantity, :pickup_time, presence: true
  validate  :pickup_date_must_be_in_the_future

  def pickup_date_must_be_in_the_future
    errors.add(:pickup_time, "can't be in the past") if
      pickup_time.present? && pickup_time < Time.now
  end
end
