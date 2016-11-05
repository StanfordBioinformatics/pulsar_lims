class SequencingRequest < ActiveRecord::Base
	has_and_belongs_to_many :libraries
	belongs_to :user
  belongs_to :sequencing_platform
  belongs_to :sequencing_center

	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
	validates :sequencing_center, presence: true
	validates :sequencing_platform, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
