class Biosample < ActiveRecord::Base
	has_and_belongs_to_many :documents
	belongs_to  :biosample_type
	belongs_to  :human_donor
  belongs_to  :vendor

	validates :term_identifier, format: {with: /\A(UBERON|EFO|CL|NTR|FBbt|WBbt):[0-9]{2,8}\Z/}
	validates :term_name, :term_identifier, presence: true
end
