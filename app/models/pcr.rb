require 'elasticsearch/model'

class Pcr < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "PCR"
  DEFINITION = "A PCR assay.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  belongs_to :analyst, class_name: "User"
  belongs_to :biosample
  belongs_to :document
  belongs_to :genomic_dna_concentration_units, class_name: "Unit"
  has_one :gel, dependent: :nullify
  belongs_to :pcr_master_mix

  validates :name, uniqueness: true, allow_blank: true
  validates :biosample, presence: true
  validates :pcr_master_mix, presence: true


  def self.policy_class
    ApplicationPolicy
  end
end
