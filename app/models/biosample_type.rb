class BiosampleType < ActiveRecord::Base
	has_one :biosample
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
