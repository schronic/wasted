class Type < ApplicationRecord
  has_many :features
  has_many :items, through: :features
  TYPES = %w[Vegan Gluten_free Hot Snack Healthy Light Home_mage Raw Vegetarian]
end
