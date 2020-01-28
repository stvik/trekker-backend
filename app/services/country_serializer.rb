class CountrySerializer

def initialize(country_object)
	@country = country_object
end

def to_serialized_json
	@country.to_json( :except => [:created_at, :updated_at])

end

end