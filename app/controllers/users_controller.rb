class UsersController < ApplicationController

	def index
		byebug
		render json: User.all
	end

	def create

		user = User.create(user_params)

		render json: user

	end

	private

	def user_params

		params.require(:user).permit(:firstname, :lastname, :username, :bio, :password, :location, :image)

	end

end
