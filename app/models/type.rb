class Type < ApplicationRecord
  has_many :features
  has_many :items, through: :features
  TYPES = ['Vegan', 'Gluten free', 'Hot', 'Snack', 'Healthy', 'Light', 'Homemade', 'Raw', 'Vegetarian']
end
