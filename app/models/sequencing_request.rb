class SequencingRequest < ActiveRecord::Base
	has_and_belongs_to_many :libraries
	belongs_to :user
  belongs_to :sequencing_platform
  belongs_to :sequencing_center
	has_one    :sequencing_result, dependent: :destroy

	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
	validates :sequencing_center, presence: true
	validates :sequencing_platform, presence: true

	accepts_nested_attributes_for :libraries, allow_destroy: true

	def self.policy_class
		ApplicationPolicy
	end
end
