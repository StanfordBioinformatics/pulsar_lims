class NucleicAcidTerm < ActiveRecord::Base
	has_many :libraries
	belongs_to :user
	validates :name, presence: true, uniqueness: true
	validates :accession, presence: true, uniqueness: true
	validates :definition, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
