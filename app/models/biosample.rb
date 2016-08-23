class Biosample < ActiveRecord::Base
	has_many :documents
	has_one  :biosample_type
	has_one  :donor
  has_one  :vendor
	validates :term_identifier, format: {with: /^(UBERON|EFO|CL|NTR|FBbt|WBbt):[0-9]{2,8}$/
end
