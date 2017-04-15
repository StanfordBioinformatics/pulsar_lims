class BiosampleType < ActiveRecord::Base
	has_one :biosample
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
