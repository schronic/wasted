class Feature < ApplicationRecord
  belongs_to :item
  belongs_to :type
end
