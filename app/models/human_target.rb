class HumanTarget < ActiveRecord::Base
	has_many :antibodies
	belongs_to :user
	validates :encode_identifier, uniqueness: true, presence: true
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
