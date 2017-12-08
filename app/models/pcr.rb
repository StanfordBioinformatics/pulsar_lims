class Pcr < ActiveRecord::Base
	DEFINITION = "A PCR assay."
	ABBR = "PCR"
  belongs_to :user
  belongs_to :pcr_master_mix
  belongs_to :crispr_modification


  def self.policy_class
    ApplicationPolicy
  end 
end
