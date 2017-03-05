class LibraryFragmentationMethod < ActiveRecord::Base
  belongs_to :user
	has_many :libraries

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
end
