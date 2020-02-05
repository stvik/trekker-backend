class UserCountrySerializer

	def initialize(user_country_object)
		@user_country = user_country_object
	end

	def to_serialized_json
		@user_country.to_json(:include => {
					:country => {:only => [:id, :name, :latitude, :longitude, :flag]}
					},
					:only => [:visited, :travel_goal, :id])
	end

end