class ReviewsController < ApplicationController

	def index
		if params[:user_id]
			reviews = Review.all.select{|review| review.user.id == params[:user_id].to_i}
		else
			reviews = Review.all
		end
		render json: ReviewSerializer.new(reviews).to_serialized_json
	end

	def create
		review = Review.create(review_params)
		render json: ReviewSerializer.new(review).to_serialized_json
	end

	def destroy
		review = Review.all.find(params[:id])
		review.destroy

		render json: ReviewSerializer.new(review).to_serialized_json
	end

	private

	def review_params

		params.require(:review).permit(:cities_visited, :likes, :dislikes, :must_see, :if_redo, :should_know, :food, :additional_info, :user_country_id)

	end

end
