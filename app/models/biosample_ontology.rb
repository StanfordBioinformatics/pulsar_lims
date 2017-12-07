class BiosampleOntology < ActiveRecord::Base
	DEFINITION = "An ontology providing biosample term names and accessions. The Biosample Term Name model links to this."
  belongs_to :user
	has_many :biosample_term_names

	scope :persisted, lambda { where.not(id: nil) }

end
