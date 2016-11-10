class Pool < ActiveRecord::Base
  belongs_to :match
  belongs_to :question
end
