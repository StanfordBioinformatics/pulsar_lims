class BiosampleOntology < ActiveRecord::Base
  include ModelConcerns
	ABBR = "BO"
	DEFINITION = "An ontology providing biosample term names and accessions. The Biosample Term Name model links to this.  Model abbreviation: #{ABBR}"
  belongs_to :user
	has_many :biosample_term_names

	scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class                                                                                
    ApplicationPolicy                                                                                  
  end  

end
