class Donor < ActiveRecord::Base
	has_many :biosamples
	belongs_to :user
	validates :encode_identifier, uniqueness: true, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
