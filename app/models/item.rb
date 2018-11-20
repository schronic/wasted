class Item < ApplicationRecord
  has_many :reservations
  belongs_to :user
  validates :name, :price, :quantity, :pickup_time, presence: true
  mount_uploader :picture, PhotoUploader
  validate :pickup_date_must_be_in_the_future
  monetize :price_cents

  def pickup_date_must_be_in_the_future
    errors.add(:pickup_time, "can't be in the past") if
      pickup_time.present? && pickup_time < Time.now
  end
end
