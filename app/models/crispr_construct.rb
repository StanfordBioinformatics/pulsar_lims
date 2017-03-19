class CrisprConstruct < ActiveRecord::Base
	has_many :crisprs
  belongs_to :user
  belongs_to :target
  belongs_to :cloning_vector
  belongs_to :vendor

	validates :cloning_vector, presence: true
	validates :name, uniqueness: true
	validates :target, presence: true	
	validates :vendor, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
