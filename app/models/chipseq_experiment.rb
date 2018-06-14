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
  has_many :control_biosample_replicates, class_name: "BiosampleReplicate", dependent: :nullify
  has_many :experiment_biosample_replicates, class_name: "BiosampleReplicate", dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :target, presence: true
end
