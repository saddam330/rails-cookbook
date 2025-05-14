
require 'open-uri'
require 'json'

puts "Cleaning database..."
Category.destroy_all
Bookmark.destroy_all
Recipe.destroy_all

categories = ['Breakfast','Pasta', 'Seafood', 'Dessert' ]

def recipe_builder(id)
  url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  response = URI.parse(url).read
  data = JSON.parse(response)["meals"][0]
  # p data["strMeal"]
  Recipe.create!(
    name: data["strMeal"],
    description:data["strInstructions"],
    image_url: data["strMealThumb"],
    rating: rand(2..5.0).round(1)
  )
end
categories.each do |category|
  url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}"
  user_serialized = URI.parse(url).read
  recipes = JSON.parse(user_serialized)
  meals = recipes["meals"].take(5)
  meals.each do |meal|
    recipe_id =  meal['idMeal']
    recipe_builder(recipe_id)
  end
end


# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# creating an arry of recipes
# Recipe.create!([
#   {
#     name: "Spaghetti Carbonara",
#     description: "Classic Roman pasta with eggs, cheese, pancetta, and pepper.",
#     image_url: "https://images.pexels.com/photos/546945/pexels-photo-546945.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
#     rating: 4.3
#   },
#   {
#     name: "Chicken Curry",
#     description: "Spicy and creamy Indian-style curry.",
#     image_url: "https://images.pexels.com/photos/9345647/pexels-photo-9345647.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
#     rating: 4.9
#   },
#   {
#     name: "Avocado Toast",
#     description: "Toasted bread topped with mashed avocado and seasoning.",
#     image_url: "https://images.pexels.com/photos/1351238/pexels-photo-1351238.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
#     rating: 4
#   },
#   {
#     name: "Beef Tacos",
#     description: "Ground beef tacos with lettuce, cheese, and salsa.",
#     image_url: "https://images.pexels.com/photos/31970715/pexels-photo-31970715/free-photo-of-authentic-mexican-tacos-with-beef-and-avocado.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
#     rating: 4.5
#   }
# ])

# # 3. Display a message 🎉
puts "Finished! Created #{Recipe.count} recipes."
