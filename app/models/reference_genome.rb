class ReferenceGenome < ActiveRecord::Base

	def self.policy_class
		ApplicationPolicy
	end 
end
