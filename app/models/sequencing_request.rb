class SequencingRequest < ActiveRecord::Base
	has_and_belongs_to_many :libraries
  belongs_to :sequencing_platform
  belongs_to :sequencing_center
	has_one    :sequencing_result, dependent: :destroy
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :sequencing_center, presence: true
	validates :sequencing_platform, presence: true

	accepts_nested_attributes_for :libraries, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
