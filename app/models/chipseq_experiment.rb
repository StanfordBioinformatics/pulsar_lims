require 'elasticsearch/model'
class ChipseqExperiment < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CS"
  DEFINITION = "A ChIP-Seq experiment"
  belongs_to :user
  belongs_to :target
  has_many :documents
  belongs_to :wild_type_input, -> {where wild_type_input: true}, class_name: "BiosampleReplicate"
  has_many :control_biosample_replicates, -> {where control: true}, class_name: "BiosampleReplicate", dependent: :nullify
  has_many :experiment_biosample_replicates, -> {where control: false}, class_name: "BiosampleReplicate", dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :target, presence: true

  def self.policy_class
    ApplicationPolicy
  end
end
