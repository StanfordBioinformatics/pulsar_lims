require 'elasticsearch/model'
class ChipseqExperiment < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CSEXP"
  DEFINITION = "A ChIP-Seq experiment"
  belongs_to :user
  belongs_to :target
  has_many :documents
  has_many :control_biosample_replicates, -> {where control: true}, class_name: "BiosampleReplicate", dependent: :nullify
  has_many :experiment_biosample_replicates, -> {where control: false}, class_name: "BiosampleReplicate", dependent: :nullify

  validates :experiment_biosample_replicates, presence: true
  validates :name, presence: true, uniqueness: true
  validates :target, presence: true

  def self.policy_class
    ApplicationPolicy
  end
end
