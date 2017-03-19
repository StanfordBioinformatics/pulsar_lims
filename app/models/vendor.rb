class Vendor < ActiveRecord::Base
	has_many :biosample
	has_many :antibodies
	has_many :crispr_constructs
	has_many :donor_constructs
	has_many :libraries
	has_many :sequencing_library_prep_kits
	belongs_to :user
	
	validates :name, presence: true, uniqueness: true
	validates :encode_identifier, presence: true, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
