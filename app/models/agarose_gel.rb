require 'elasticsearch/model'

class AgaroseGel < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "AG"
  DEFINITION = "Represents an agarose gel used in electrophoresis."

  belongs_to :immunoblot
  belongs_to :user
  has_many :gel_lanes, dependent: :destroy

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
    "#{AgaroseGel::ABBR}-#{self.id}"
  end

end
