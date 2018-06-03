require 'elasticsearch/model'
class Attachment < ActiveRecord::Base
  include ModelConcerns
  DEFINITION = "DEPRECATED! Will soon be removed."
  #mount_uploader :file, AttachmentUploader
  belongs_to :user

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 
end
