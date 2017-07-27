class ConstructTag < ActiveRecord::Base
	has_and_belongs_to_many :crispr_constructs
	has_and_belongs_to_many :donor_constructs
  belongs_to :user

	validates :name, presence: true, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end

end
