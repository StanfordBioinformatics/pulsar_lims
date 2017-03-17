class ConstructTag < ActiveRecord::Base
  belongs_to :user
	belongs_to :donor_construct

	validates :name, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
