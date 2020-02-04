class UserCountriesController < ApplicationController

	def index
		render json: UserCountry.all
	end

	def create
		uc = UserCountry.create(user_country_params)

		render json: uc
	end

	private

	def user_country_params
		params.require(:user_country).permit(:user_id, :country_id, :visited, :travel_goal, :recommendation)

	end


end
