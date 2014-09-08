class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :tutor
  belongs_to :tutor_profile

	validates :rating, :comment, presence: true
	validates :rating, numericality: {
		greater_than_or_equal_to: 1,
		message: "can only be a whole number between 1 and 5"
	}
	
end
