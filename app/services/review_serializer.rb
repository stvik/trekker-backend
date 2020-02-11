class ReviewSerializer

	def initialize(review_object)
		@review = review_object
	end

	def to_serialized_json
		@review.to_json(:include => {
					:user => {:except => [:password, :created_at, :updated_at]}
					},
					:except => [:created_at])
	end

end

