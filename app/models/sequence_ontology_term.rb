class SequenceOntologyTerm < ActiveRecord::Base
	validates :name, :accession, :definition, presence: true
	validates :accession, :name, uniqueness: true
end
