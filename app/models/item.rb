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

  private

  mount_uploader :picture, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  TYPES = %w[Vegan Gluten_free Hot Snack Healthy Light Home_mage Raw Vegetarian]
  CATEGORY = %w[Asian Breakfast Burgers Chinese Greek HealthyFood HomeMade Indian
                  International Italian Japanese Mediterranean Mexican Middle Eastern Nepalese
                  Pizza Sandwiches Sushih Thai Vietnamese]

  include PgSearch

  multisearchable against: [ :name, :description, :price, :address, :category, :food_type ]

  PgSearch.multisearch_options = {
  using: { tsearch: { prefix: true } }
  }

  def pickup_date_must_be_in_the_future
    errors.add(:pickup_time, "can't be in the past") if
      pickup_time.present? && pickup_time < Time.now
  end
end

