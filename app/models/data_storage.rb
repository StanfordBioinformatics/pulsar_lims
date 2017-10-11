class DataStorage < ActiveRecord::Base
  belongs_to :user
	belongs_to :data_storage_provider
	has_many :file_references, dependent: :destroy

	validates :name, presence: true, uniqueness: true
	validates_presence_of :bucket, if: "self.data_storage_provider.bucket_storage?"
	validates_uniqueness_of :bucket, scope: :data_storage_provider_id, allow_blank: true
	validates_presence_of :project_identifier, if: "self.data_storage_provider.name == DataStorageProvider::DNANEXUS"

  def self.policy_class
    ApplicationPolicy
  end 

	def bucketed?
		if self.data_storage_provider.bucket_storage?
			return true
		end
		return false
	end

	private
	
end
