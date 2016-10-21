class ExperimentType < ActiveRecord::Base

	def self.policy_class
		ApplicationPolicy
	end 
end
