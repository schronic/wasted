class Item < ApplicationRecord

  has_many    :reservations
  has_many    :purchased_items
  belongs_to  :user
  has_many    :features, dependent: :destroy
  has_many    :types, through: :features

  validates   :name,
              :price,
              :quantity,
              :pickup_time,
              presence: true
  validate    :pickup_date_must_be_in_the_future

  monetize :price_cents

  private

  mount_uploader :picture, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  TYPES = %w[Vegan Gluten_free Hot Snack Healthy Light Home_mage Raw Vegetarian]

  CATEGORY = %w[Asian Breakfast Burgers Chinese Greek HealthyFood HomeMade Indian
                  International Italian Japanese Mediterranean Mexican Middle Eastern Nepalese
                  Pizza Sandwiches Sushih Thai Vietnamese]

  include PgSearch
  pg_search_scope :search_by_title_and_syllabus,
    against: [ :name, :description, :price, :address ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def pickup_date_must_be_in_the_future
    errors.add(:pickup_time, "can't be in the past") if
      pickup_time.present? && pickup_time < Time.now
  end
end

