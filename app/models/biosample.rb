class Biosample < ActiveRecord::Base
	has_and_belongs_to_many :documents
	belongs_to  :biosample_type
	belongs_to  :human_donor
  belongs_to  :vendor

	validates :term_identifier, format: {with: /\A(UBERON|EFO|CL|NTR|FBbt|WBbt):[0-9]{2,8}\Z/}
	validates :documents, :biosample_type_id, :vendor_id, :term_identifier, :human_donor_id, presence: true
end
