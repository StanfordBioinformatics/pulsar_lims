class ExperimentType < ActiveRecord::Base
	belongs_to :user
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
