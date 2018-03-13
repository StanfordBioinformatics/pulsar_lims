class FileReference < ActiveRecord::Base
  include ModelConcerns
	ABBR = "FR"
	DEFINITION = "Refers to a file or folder within a specific Data Storage object.  Model abbreviation: #{ABBR}"
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
			txt += " #{ds.project_identifier}:#{self.file_path}" 
		end
		return txt
	end

	private

	def validate_file_path
		base_path = self.data_storage.folder_base_path
		if not self.file_path.start_with?(base_path)
			self.file_path = File.join(base_path,self.file_path)
		end
	end
end
