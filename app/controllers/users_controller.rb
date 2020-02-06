class UsersController < ApplicationController

	def index
		render json: UserSerializer.new(User.all).to_serialized_json
	end

	def create

		user = User.create(user_params)

		render json: UserSerializer.new(user).to_serialized_json

	end

	def login
		user = User.find_by(username: params[:username])
		render json: UserSerializer.new(user).to_serialized_json
	end

	def update
		user = User.find(params[:id])
		user.update(user_params)
		render json: UserSerializer.new(user).to_serialized_json
	end

	private

	def user_params

		params.require(:user).permit(:firstname, :lastname, :username, :bio, :password, :location, :image)

	end

end
