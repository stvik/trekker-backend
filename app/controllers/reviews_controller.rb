class ReviewsController < ApplicationController

	def index

		render json: Review.all
	end

	def create
		review = Review.create(review_params)
		render json: review
	end

	private

	def review_params

		params.require(:review).permit(:cities_visited, :likes, :dislikes, :must_see, :if_redo, :should_know, :food, :additional_info, :user_country_id)

	end

end
