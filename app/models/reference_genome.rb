class ReferenceGenome < ActiveRecord::Base
	ABBR = "RG"
	DEFINITION = "A reference genome build for a particular organism, i.e. hg38.  Model abbreviation: #{ABBR}"
	has_many :chromosomes, dependent: :destroy
	belongs_to :user
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
