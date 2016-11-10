class Question < ActiveRecord::Base

	 has_many :pools
	 has_many :matches, through: :pools, inverse_of: :questions
end
