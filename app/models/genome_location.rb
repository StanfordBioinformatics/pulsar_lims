class GenomeLocation < ActiveRecord::Base
  include ModelConcerns
	ABBR = "GL"
	DEFINITION = "The coordinates of a genome feature on a chromosome of a particular Reference Genome.  Model abbreviation: #{ABBR}"
	has_many :crispr_modifications
  belongs_to :user
  belongs_to :chromosome

	validates :start, presence: true
	validates :chromosome, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
