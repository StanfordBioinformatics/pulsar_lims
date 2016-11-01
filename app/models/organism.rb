class Organism < ActiveRecord::Base
	has_many :antibodies
	belongs_to :user
	validates :name, uniqueness: true, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
