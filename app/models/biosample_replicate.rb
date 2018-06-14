require 'elasticsearch/model'
class BiosampleReplicate < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "BR"
  DEFINITION = "A replicate of a biosample, used in experiments such as a Chipseq experiment."
  belongs_to :biosample
  belongs_to :chipseq_experiment
  belongs_to :user
  has_many :documents

  validates :name, presence: true
  validates :biosample, presence: true
  validates :biological_replicate_number, presence: true

  def self.policy_class
    ApplicationPolicy
  end
end
