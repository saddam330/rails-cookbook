class Bookmark < ApplicationRecord
  belongs_to :recipe
  belongs_to :category
  validates :recipe_id, uniqueness: { scope: :category_id }
  validates :coment, length: { minimum: 6 }
end
