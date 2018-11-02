require 'elasticsearch/model'

class Pcr < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "PCR"
  DEFINITION = "A PCR assay.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  has_one :gel, dependent: :nullify
  belongs_to :pcr_master_mix
  belongs_to :crispr_modification

  validates :name, presence: true
  validates :pcr_master_mix, presence: true


  def self.policy_class
    ApplicationPolicy
  end 
end
