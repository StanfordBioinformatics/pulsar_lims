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
  validate :validate_replicates 
    # Make sure that this biosample can only have multiple technical biosample_replicates,
    # and not multiple biosample replicates of the same object type. Also make sure that all replicates
    # of a given experiment are on the same experiment. 

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def display
    self.name + " [#{self.biological_replicate_number},#{self.technical_replicate_number}]"
  end

  private

  def validate_replicates
    # validates that if a Biosample is going to have multiple BiosampleReplicates, that they are all
    # technical replicates whereby each BiosampleReplicate's biological_replicate_number attribute is
    # the same, but varies with regard to the technical_replicate_number attribute.
    brn = self.biological_replicate_number
    trn = self.technical_replicate_number
    self.biosample.biosample_replicates.persisted.each do |rep|
      next if self.id == rep.id
      if brn != rep.biological_replicate_number
        self.errors.add(:biological_replicate_number, "must be the same as any existing BiosampleReplicate objects associated with the selected Biosample. This is because a Biosample can only be associated to one biological replicate in the technical sense. It can, however, have multiple technical replicates, in which case each associated BiosampleReplicate object must have the same number set for the 'biological_replicate_number' attribute, but a different value for each 'technical_replicate_number' attribute.")
      end
      if trn == rep.technical_replicate_number
        self.errors.add(:technical_replicate_number, "must be set to a different value than other technical replicates associated to the same biosample.")
      end
    end
  end
end
