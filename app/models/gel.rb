require 'elasticsearch/model'

class Gel < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "GEL"
  DEFINITION = "Represents an agarose or polyacrylamide gel used in electrophoresis. Model abbreviation: #{ABBR}"

  belongs_to :immunoblot
  belongs_to :pcr
  belongs_to :user
  has_many :gel_lanes, dependent: :destroy
  has_many :biosamples, through: :gel_lanes
  validates :voltage, numericality: {greater_than: 0}, allow_blank: true
  validate :validate_owner, on: [:create, :update]

  accepts_nested_attributes_for :gel_lanes, allow_destroy: true 

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def s3_direct_post
    # Used for getting a bucket object URI for uploading a gel image.
    # Called in the controller via a private method with the same name. 
    return S3_BUCKET.presigned_post(key: "images/gels/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end

  def display
    "#{Gel::ABBR}-#{self.id}"
  end

private

  def validate_owner
    if self.pcr_id and self.immunoblot_id
        self.errors.add(:base, "can't be linked to both a PCR and an Immunoblot.")
    end
  end

end
