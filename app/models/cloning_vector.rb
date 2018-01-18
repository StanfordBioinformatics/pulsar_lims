class CloningVector < ActiveRecord::Base
	ABBR = "CV"
	DEFINITION = "The vector backbone that you use to insert DNA of interest for cloning. Model abbreviation: #{ABBR}"
	has_many :crispr_constructs
	has_many :donor_constructs
  belongs_to :user
	belongs_to :vendor

	validates :name, uniqueness: true
	validates :vendor_id, presence: true
	validates :product_url, uniqueness: {message: "must be unique"}, allow_blank: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end
end
