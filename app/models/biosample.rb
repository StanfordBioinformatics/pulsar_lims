class Biosample < ActiveRecord::Base
	has_and_belongs_to_many :documents
	belongs_to  :biosample_type
	belongs_to  :donor
  belongs_to  :vendor
	has_many    :libraries
	
	validates :name, length: { maximum: 20 }, presence: true, allow_blank: false, uniqueness: true
	validates :ontology_term_accession, format: {with: /\A(UBERON|EFO|CL|NTR|FBbt|WBbt):[0-9]{2,8}\Z/}, presence: true
	validates :documents, :biosample_type_id, :vendor_id, :donor_id, presence: true

end
