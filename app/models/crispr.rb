class Crispr < ActiveRecord::Base
  belongs_to :user
  belongs_to :biosample
  belongs_to :crispr_construct
  belongs_to :donor_construct
	belongs_to :genomic_integration_site, class_name: "GenomeLocation"

	validates :name, presence: true, uniqueness: true
	validates :biosample, presence: true
	validates :crispr_construct, presence: true
	validates :donor_construct, presence: true

	accepts_nested_attributes_for :genomic_integration_site, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	before_save :verify_target

	def self.policy_class
		ApplicationPolicy
	end

	protected
		def verify_target
			if self.crispr_construct.target.id != self.donor_construct.target.id
				self.errors.add(:target_id,"must be the same between the Crispr Construct and the Donor Construct.")
				return false
			end
		end
end
