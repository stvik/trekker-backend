class User < ApplicationRecord
	has_many :user_countries
	has_many :countries, through: user_countries
end
