class FileReference < ActiveRecord::Base
  belongs_to :user
	belongs_to :data_file_type
  belongs_to :data_storage

	validates :data_storage_id, presence: true
	validates_presence_of :file_path, if: "self.data_storage.bucketed?"
	validates_presence_of :data_file_type

  def self.policy_class
    ApplicationPolicy
  end 
end
