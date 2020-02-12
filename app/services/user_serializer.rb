class UserSerializer

	def initialize(user_object)
		@user = user_object
	end

	def to_serialized_json
		@user.to_json( 
			:include => {
			:user_countries => {
				:include => {
					:country => {:only => [:id, :name, :latitude, :longitude, :flag]},
					:review => {:except => [:created_at, :user_country_id]}
				},
				:only => [:visited, :travel_goal, :id]}
			},
			:except => [:password, :created_at, :updated_at])
	end

end