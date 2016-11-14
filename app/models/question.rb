class Question < ActiveRecord::Base

	 has_many :pools
	 has_many :matches, through: :pools, inverse_of: :questions

	 def retrieve(value)
	 	case value
	 		when 1
	 			return self.answer1
	 		when 2
	 			return self.answer2
	 		when 3
	 			return self.answer3
	 		when 4
	 			return self.answer4
	 		else
	 	end

	 end
end
