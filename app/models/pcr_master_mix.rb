class PcrMasterMix < ActiveRecord::Base
  belongs_to :user
  belongs_to :vendor

	validates :name, presence: true, uniqueness: true
	validates :vendor_id, presence: true
	
  def self.policy_class
    ApplicationPolicy
  end 
end
