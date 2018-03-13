class ExperimentType < ActiveRecord::Base
  include ModelConcerns
	ABBR = "ETY"
	DEFINITION = "The type of experiment, such as ATAC-Seq, ChIP-Seq, ... Model abbreviation: #{ABBR}"
	belongs_to :user
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
