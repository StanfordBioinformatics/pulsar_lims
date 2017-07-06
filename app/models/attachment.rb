class Attachment < ActiveRecord::Base
	mount_uploader :file, AttachmentUploader
	belongs_to :user

	scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 
end
