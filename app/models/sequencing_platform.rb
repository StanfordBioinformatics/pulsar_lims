class SequencingPlatform < ActiveRecord::Base
	DEFINITION = "The type of sequencing machine, i.e. Illumina MiSeq, Illumina HiSeq 4000."
	ABBR = "SP"
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
