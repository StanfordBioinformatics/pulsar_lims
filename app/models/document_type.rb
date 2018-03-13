class DocumentType < ActiveRecord::Base
  include ModelConcerns
	ABBR = "DOCTY"
	DEFINITION = "The type of protocol.  Model abbreviation: #{ABBR}"
	has_many :documents
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
