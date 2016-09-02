class Library < ActiveRecord::Base
	has_and_belongs_to_many :documents
  belongs_to :sequence_ontology_term
  belongs_to :biosample
  belongs_to :antibody
  belongs_to :vendor
	validates :name, length: { maximum: 20 }
end
