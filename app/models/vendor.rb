class Vendor < ActiveRecord::Base
	ABBR = "V"
  DEFINITION = "A source, such as a person, lab, or industry, from where a product was procured.  Model abbreviation: #{ABBR}"
	has_many :biosample
	has_many :antibodies
	has_many :crispr_constructs
	has_many :donor_constructs
	has_many :libraries
	has_many :pcr_master_mixes
	has_many :plates
	has_many :sequencing_library_prep_kits
	belongs_to :user
	
	validates :name, presence: true, uniqueness: true
	validates :encode_identifier, uniqueness: true, allow_blank: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
