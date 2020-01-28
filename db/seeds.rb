# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'
require 'faker'

City.destroy_all
Country.destroy_all

countries = RestClient.get('https://restcountries.eu/rest/v2/all')

countries_array = JSON.parse(countries)

countries_array.each do |country|
	Country.create(
		name: country['name'],
		continent: country['region'],
		latitude: country['latlng'][0],
		longitude: country['latlng'][1],
		languages: country['languages'][0]['name'],
		currency: country['currencies'][0]['name'],
		population: country['population'],
		country_code: country['alpha2Code'],
		description: Faker::Lorem.paragraph(sentence_count: 8)
		)
end

Country.all.each do |country|
	10.times do 
			City.create(
			name: Faker::Address.city,
			latitude: Faker::Address.latitude,
			longitude: Faker::Address.longitude,
			description: Faker::Lorem.paragraph(sentence_count: 3),
			capital: false,
			country_id: country.id
			)

	end	

	capital = country.cities.last
	capital.update_attributes(:capital => true)

end






0
