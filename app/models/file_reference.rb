class FileReference < ActiveRecord::Base
  belongs_to :user
	belongs_to :data_file_type
  belongs_to :data_storage
	has_many   :sequencing_runs, foreign_key: :storage_location_id, dependent: :nullify

	validates :data_storage_id, presence: true
	validates_presence_of :file_path, if: "self.data_storage.bucketed?"
	validates_presence_of :data_file_type
	validate :validate_file_path

  def self.policy_class
    ApplicationPolicy
  end 

	def display
		ds = self.data_storage
		bucket = ds.bucket
		dsp = ds.data_storage_provider
		txt = "#{dsp.name}"
		if bucket.present?
			txt += " #{bucket}"
		else
			txt += " project #{ds.project_identifier}" 
		end
		if self.file_path.present?
			txt += ", path "  + self.file_path
		end
		return txt
	end

	private

	def validate_file_path
		base_path = self.data_storage.folder_base_path
		if base_path.present?
			if not self.file_path.start_with?(base_path)
				path = File.join(base_path,self.file_path)
				self.file_path = path
			end
		end
	end
end
