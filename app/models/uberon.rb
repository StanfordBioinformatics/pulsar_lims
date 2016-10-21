class Uberon < ActiveRecord::Base
	validates :name, :accession, presence: true
	validates :accession, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
