class CountriesController < ApplicationController


	def index
		countries = Country.all
		render json: CountrySerializer.new(countries).to_serialized_json
	end
end
