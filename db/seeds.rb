# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'
require 'faker'

# UserCountry.destroy_all

# Review.destroy_all


# City.destroy_all

# Country.destroy_all

# countries = RestClient.get('https://restcountries.eu/rest/v2/all')

# countries_array = JSON.parse(countries)

# countries_array.each do |country|
# 	Country.create(
# 		name: country['name'],
# 		continent: country['region'],
# 		latitude: country['latlng'][0],
# 		longitude: country['latlng'][1],
# 		languages: country['languages'][0]['name'],
# 		currency: country['currencies'][0]['name'],
# 		population: country['population'],
# 		country_code: country['alpha2Code'],
# 		flag: country['flag'],
# 		description: Faker::Lorem.paragraph(sentence_count: 8)
# 		)
# end

# Country.all.each do |country|
# 	10.times do 
# 			City.create(
# 			name: Faker::Address.city,
# 			latitude: Faker::Address.latitude,
# 			longitude: Faker::Address.longitude,
# 			description: Faker::Lorem.paragraph(sentence_count: 3),
# 			capital: false,
# 			country_id: country.id
# 			)

# 	end	



# end

countries = Country.select {|c| c.id > 1249}

countries.each do |country|
	cities = RestClient.get("https://www.triposo.com/api/20190906/location.json?type=city&countrycode=#{country.country_code.downcase}&order_by=-score&count=10&fields=snippet,images,coordinates,score,name&account=&token=")

	cities_array = JSON.parse(cities)

	cities_array["results"].each do |city|
		City.create(
			name: city["name"],
			latitude: city["coordinates"]["latitude"],
			longitude: city["coordinates"]["longitude"],
			description: city["snippet"],
			score: city['score'],
			image: city["images"][0]["source_url"],
			country_id: country.id

			 )
	end
end
0
