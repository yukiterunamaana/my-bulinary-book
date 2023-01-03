class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
  validates :measurement_unit, presence: true
end
