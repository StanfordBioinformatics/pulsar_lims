class BiosampleOntology < ActiveRecord::Base
  belongs_to :user
	has_many :biosample_term_names

end
