class Biosample < ActiveRecord::Base
	has_and_belongs_to_many :documents
	belongs_to :user
	belongs_to  :biosample_type
	belongs_to  :donor
  belongs_to  :vendor
	has_many    :libraries
	
	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
	validates :ontology_term_accession, format: {with: /\A(UBERON|EFO|CL|NTR|FBbt|WBbt):[0-9]{2,8}\Z/}, presence: true
	validates :documents, presence: true
	validates :biosample_type_id, presence: true
	validates :vendor_id, presence: true
	validates :donor_id, presence: true

	accepts_nested_attributes_for :documents, allow_destroy: true

	def self.policy_class
		ApplicationPolicy
	end 

end
