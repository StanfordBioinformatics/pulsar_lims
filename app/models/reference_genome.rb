class ReferenceGenome < ActiveRecord::Base
	belongs_to :user

	def self.policy_class
		ApplicationPolicy
	end 
end
