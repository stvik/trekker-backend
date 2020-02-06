class UserCountry < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_one :review
end
