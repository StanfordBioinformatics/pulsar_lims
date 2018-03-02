class SequencingPlatform < ActiveRecord::Base
	ABBR = "SP"
	DEFINITION = "The type of sequencing machine, i.e. Illumina MiSeq, Illumina HiSeq 4000.  Model abbreviation: #{ABBR}"
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
