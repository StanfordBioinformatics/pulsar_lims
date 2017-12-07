class PcrMasterMix < ActiveRecord::Base
	DEFINITION = "The master mix used in a PCR assay."
  belongs_to :user
  belongs_to :vendor

	validates :name, presence: true, uniqueness: true
	validates :vendor_id, presence: true
	
  def self.policy_class
    ApplicationPolicy
  end 
end
