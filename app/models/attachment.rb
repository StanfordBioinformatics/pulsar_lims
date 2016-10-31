class Attachment < ActiveRecord::Base
	mount_uploader :file, AttachmentUploader

  def self.policy_class
    ApplicationPolicy
  end 
end
