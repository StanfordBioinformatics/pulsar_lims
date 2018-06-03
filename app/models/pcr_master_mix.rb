require 'elasticsearch/model'

class PcrMasterMix < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "PCRM"
  DEFINITION = "The master mix used in a PCR assay.  Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :vendor

  validates :name, presence: true, uniqueness: true
  validates :vendor_id, presence: true
  
  def self.policy_class
    ApplicationPolicy
  end 
end
