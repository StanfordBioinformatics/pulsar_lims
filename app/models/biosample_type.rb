class BiosampleType < ActiveRecord::Base
	has_one :biosample
	belongs_to :user
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
