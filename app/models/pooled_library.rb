class PooledLibrary < ActiveRecord::Base
	has_many :libraries
	has_many :plates
	has_many :sequencing_requests
  belongs_to :user
  belongs_to :sequencing_library_prep_kit

	validates :sequencing_library_prep_kit, presence: true
	validates  :size_range, format: {with: /\A\d+-\d+\Z/}, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
