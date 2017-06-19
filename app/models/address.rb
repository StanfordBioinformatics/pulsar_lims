class Address < ActiveRecord::Base
	belongs_to :user

	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :postal_code, presence: true
	validates :country, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
