

class CountrySerializer

	def initialize(country_object)
		@country = country_object
	end

	def to_serialized_json
		@country.to_json( :except => [:created_at, :updated_at])

	end

	def to_serialized_json_with_cities
		@country.to_json( :include => {
			:cities => {:except => [:country_id, :created_at, :updated_at]},
			:reviews => {
					:include => {
						:user => {:except => [:password, :created_at, :updated_at]}},
					:except => [:created_at]}
		}, :except => [:updated_at, :created_at])
	end

end