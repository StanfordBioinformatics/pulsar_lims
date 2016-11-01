class Attachment < ActiveRecord::Base
	mount_uploader :file, AttachmentUploader
	belongs_to :user

  def self.policy_class
    ApplicationPolicy
  end 
end
