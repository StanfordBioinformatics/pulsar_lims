class Library < ActiveRecord::Base
	has_and_belongs_to_many :documents
  belongs_to :sequence_ontology_term
  belongs_to :biosample
  belongs_to :antibody
  belongs_to :vendor
	validates :name, length: { maximum: 20 }
	validates  :size_range, format: {with: /\A\d+-\d+\Z/}
	validates :name, :sequence_ontology_term_id, :biosample_id, :vendor_id,  :size_range, presence: true
	#The fkey antibody_id doesn't need to be required since some libraries, such as ATAC-SEq, don't have an antibody.
end
