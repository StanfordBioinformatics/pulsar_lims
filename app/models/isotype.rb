class Isotype < ActiveRecord::Base
	has_many :antibodies
	validates :name, presence: true, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
