class Item < ApplicationRecord
  has_many    :reservations
  has_many    :purchased_items
  belongs_to  :user
  validates   :name,
              :price,
              :quantity,
              :pickup_time,
              presence: true
  validate    :pickup_date_must_be_in_the_future

  mount_uploader :picture, PhotoUploader

  private

  def pickup_date_must_be_in_the_future
    errors.add(:pickup_time, "can't be in the past") if
      pickup_time.present? && pickup_time < Time.now
  end
end
