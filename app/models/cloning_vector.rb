require 'elasticsearch/model'
class CloningVector < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CV"
  DEFINITION = "The vector backbone that you use to insert DNA of interest for cloning.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  has_many :crispr_constructs
  has_many :donor_constructs
  belongs_to :user
  belongs_to :vendor

  validates :name, uniqueness: true, presence: true
  validates :vendor_id, presence: true
  validates :product_url, uniqueness: {message: "must be unique"}, allow_blank: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def s3_direct_post                                                                                   
    # Used for getting a bucket object URI for uploading a gel image.                                  
    # Called in the controller via a private method with the same name.                                
    return S3_BUCKET.presigned_post(key: "images/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end
end
