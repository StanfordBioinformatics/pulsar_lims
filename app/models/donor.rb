class Donor < ActiveRecord::Base
	has_many :biosamples
	belongs_to :user
	validates :encode_identifier, uniqueness: true, presence: true
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
