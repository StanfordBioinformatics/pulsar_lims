class GenomeLocation < ActiveRecord::Base
	has_many :crisprs
  belongs_to :user
  belongs_to :chromosome

	validates :start, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
