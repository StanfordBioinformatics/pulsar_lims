class CrisprGeneticModification < ActiveRecord::Base
	has_and_belongs_to_many :documents
  belongs_to :user
  belongs_to :vendor

	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
end
