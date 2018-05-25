class Pcr < ActiveRecord::Base
  include ModelConcerns
  ABBR = "PCR"
  DEFINITION = "A PCR assay.  Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :pcr_master_mix
  belongs_to :crispr_modification

  validates :name, presence: true
  validates :pcr_master_mix, presence: true


  def self.policy_class
    ApplicationPolicy
  end 
end
