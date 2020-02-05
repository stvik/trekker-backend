class UserCountriesController < ApplicationController

	def index
		render json: UserCountrySerializer.new(UserCountry.all).to_serialized_json
	end

	def create
		uc = UserCountry.create(user_country_params)

		render json: UserCountrySerializer.new(uc).to_serialized_json
	end

	def destroy
		uc = UserCountry.find(params[:id])
		uc.destroy

		render json: uc

	end

	private

	def user_country_params
		params.require(:user_country).permit(:user_id, :country_id, :visited, :travel_goal, :recommendation)

	end


end
