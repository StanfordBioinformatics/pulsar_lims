class GenomeLocation < ActiveRecord::Base
	DEFINITION = "The coordinates of a genome feature on a chromosome of a particular Reference Genome."
	ABBR = "GL"
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
