class LibraryFragmentationMethod < ActiveRecord::Base
	DEFINITION = "The method used to shear the DNA during Library preparation."
  belongs_to :user
	has_many :libraries

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
