class Country < ApplicationRecord
	has_many :cities
	has_many :user_countries
	has_many :users, through: :user_countries
	has_many :reviews, through: :user_countries
end
