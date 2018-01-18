class Chromosome < ActiveRecord::Base
	ABBR = "CHR"
	DEFINITION = "A chromosome identifier of a particular reference genome build. Model abbreviation: #{ABBR}"
	has_many :genome_locations
  belongs_to :user
  belongs_to :reference_genome

	validates :reference_genome_id, presence: true
	validates_uniqueness_of :name, scope: :reference_genome_id
	validates :name, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
