class Recipe < ApplicationRecord
  has_many :bookmarks
  validates :description, presences: true
  validates :name, presences: true, uniqueness: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

end
