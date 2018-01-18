class Pcr < ActiveRecord::Base
	ABBR = "PCR"
	DEFINITION = "A PCR assay. Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :pcr_master_mix
  belongs_to :crispr_modification


  def self.policy_class
    ApplicationPolicy
  end 
end
