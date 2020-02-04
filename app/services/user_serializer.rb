class UserSerializer

	def initialize(user_object)
		@user = user_object
	end

	def to_serialized_json
		@user.to_json( 
			:include => {
			:user_countries => {
				:include => {
					:country => {:only => [:name, :latitude, :longitude]}},
				:except => [:created_at, :updated_at, :recommendation, :user_id]}
			},
			:except => [:password, :created_at, :updated_at])
	end

end