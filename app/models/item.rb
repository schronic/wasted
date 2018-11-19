class Item < ApplicationRecord
  has_many :reservations
  validates :name, :price, :quantity, :pickup_time, presence: true
  mount_uploader :picture, PhotoUploader
  validate  :pickup_date_must_be_in_the_future

  def pickup_date_must_be_in_the_future
    errors.add(:pickup_date, "can't be in the past") if
      pickup_date.present? && pickup_date < Time.now
  end
end
