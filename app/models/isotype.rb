class Isotype < ActiveRecord::Base
	has_many :antibodies
	belongs_to :user
	validates :name, presence: true, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
