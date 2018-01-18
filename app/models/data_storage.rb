class DataStorage < ActiveRecord::Base
	ABBR = "DS"
	DEFINITION = "A reference to a storage unit of a particular Data Storage Provider. For example, this could be a particular AWS S3 bucket, or even a particular file tree within an AWS bucket for finer grained management. Model abbreviation: #{ABBR}"
  belongs_to :user
	belongs_to :data_storage_provider
	has_many :sequencing_runs
	has_many :file_references, dependent: :nullify

	validates :name, presence: true, uniqueness: true
	validates_presence_of :bucket, if: "self.data_storage_provider.bucket_storage?"
	validates_presence_of :project_identifier, if: "self.data_storage_provider.name == DataStorageProvider::DNANEXUS"

	validate :validate_folder_base_path

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

	def validate_folder_base_path
		path = self.folder_base_path
		if not path.start_with?("/")
			path = "/" + path
		end
		if not path.end_with?("/")
			path = path + "/"
		end
		self.folder_base_path = path
	end
	
end
