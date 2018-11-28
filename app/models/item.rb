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
              :address,
              presence: true
  validate    :pickup_date_must_be_in_the_future

  monetize :price_cents

  private

  mount_uploader :picture, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  TYPES = %w[Vegan GlutenFree Hot Snack Healthy Light HomeMade Raw Vegetarian]

  CATEGORY = %w[Asian Breakfast Burgers Chinese Greek HealthyFood HomeMade Indian
                  International Italian Japanese Mediterranean Mexican MiddleEastern Nepalese
                  Pizza Sandwich Sushi Thai Vietnamese]

  include PgSearch
  pg_search_scope :search_by_title_and_syllabus,
    against: [ :name, :description, :price, :address ],
    using: {
      tsearch: { prefix: true }
    }

  def pickup_date_must_be_in_the_future
    errors.add(:pickup_time, "can't be in the past") if
      pickup_time.present? && pickup_time < Time.now
  end
end

