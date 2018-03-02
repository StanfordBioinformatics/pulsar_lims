class Address < ActiveRecord::Base
	ABBR = "AD"
	DEFINITION = "A postal address.  Model abbreviation: #{ABBR}"
	belongs_to :user

	validates :street, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :postal_code, presence: true
	validates :country, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
