class Match < ActiveRecord::Base

	has_many :pools
	has_many :games
	has_many :users, through: :games, inverse_of: :matches
	has_many :questions, through: :pools, inverse_of: :matches

	validates :title, uniqueness: true
end
