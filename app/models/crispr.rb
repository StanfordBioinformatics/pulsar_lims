class Crispr < ActiveRecord::Base
  belongs_to :user
  belongs_to :biosample
  belongs_to :crispr_construct
  belongs_to :donor_construct
	belongs_to :genomic_integration_site, class_name: "GenomeLocation"

	validates :name, uniqueness: true
	validates :biosample, presence: true
	validates :crispr_construct, presence: true
	validates :donor_construct, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
