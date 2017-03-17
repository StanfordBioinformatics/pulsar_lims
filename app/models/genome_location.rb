class GenomeLocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :chromosome

	validates :name, presence: true
	validates :start, presence: true

	def self.policy_scope
		ApplicationPolicy
	end
end
