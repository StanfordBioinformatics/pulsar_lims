class SequencingPlatform < ActiveRecord::Base

	def self.policy_class
		ApplicationPolicy
	end 
end
