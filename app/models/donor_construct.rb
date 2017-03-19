class DonorConstruct < ActiveRecord::Base
	has_many :construct_tags
	has_many :crisprs
  belongs_to :user
  belongs_to :cloning_vector
  belongs_to :vendor
  belongs_to :target

	validates :name, presence: true
	validates :cloning_vector, presence: true
	validates :vendor_id, presence: true
	validates :target_id, presence: true

	accepts_nested_attributes_for :construct_tags, allow_destroy: true

	def self.policy_class
		ApplicationPolicy
	end
end
