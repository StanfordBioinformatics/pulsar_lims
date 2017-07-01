class BiosampleType < ActiveRecord::Base
	has_many :biosamples
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
