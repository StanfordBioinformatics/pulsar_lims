class CloningVector < ActiveRecord::Base
	has_many :donor_constructs
  belongs_to :user

	validates :name, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
end
