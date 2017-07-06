class Organism < ActiveRecord::Base
	has_many :antibodies
	belongs_to :user
	validates :name, uniqueness: true, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
