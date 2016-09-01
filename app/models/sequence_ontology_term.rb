class SequenceOntologyTerm < ActiveRecord::Base
	has_many :libraries
	validates :name, :accession, :definition, presence: true
	validates :accession, :name, uniqueness: true
end
