# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
	Ingredient.delete_all
	open("#{Rails.root}/ingredients") do |ingredients|
		ingredients.read.each_line do |ingredient|
		Ingredient.create!(:name => ingredient[0..-2])
	end
end