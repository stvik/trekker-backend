class Review < ApplicationRecord
  belongs_to :user_country
  has_one :country, through: :user_country
  has_one :user, through: :user_country
end
