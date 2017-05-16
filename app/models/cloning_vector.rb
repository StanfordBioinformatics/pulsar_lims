class CloningVector < ActiveRecord::Base
	has_many :crispr_constructs
	has_many :donor_constructs
  belongs_to :user
	belongs_to :vendor

	validates :name, uniqueness: true
	validates :vendor_id, presence: true
	validates :product_url, uniqueness: {message: "must be unique"}, allow_blank: true

	def self.policy_class
		ApplicationPolicy
	end
end
