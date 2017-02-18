class Uberon < ActiveRecord::Base
	belongs_to :user
	validates :accession, presence: true, uniqueness: true
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
