require 'elasticsearch/model'
class FileReference < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "FR"
  DEFINITION = "Refers to a file or folder within a specific Data Storage object.  Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :data_file_type
  belongs_to :data_storage
  has_one    :analysis_merged_bam_file, class_name: "Analysis", foreign_key: :merged_bam_file_id, dependent: :nullify
  has_one    :analysis_merged_peaks_file, class_name: "Analysis", foreign_key: :merged_peaks_file_id, dependent: :nullify
  has_one    :analysis_merged_qc_file, class_name: "Analysis", foreign_key: :merged_qc_file_id, dependent: :nullify

  validates :data_storage_id, presence: true
  validates_presence_of :file_path, if: "self.data_storage.bucketed?"
  validates_presence_of :data_file_type
  validate :validate_file_path

  def self.policy_class
    ApplicationPolicy
  end 

  def to_label
    super + " " + self.display() 
  end
  def display
    ds = self.data_storage
    bucket = ds.bucket
    dsp = ds.data_storage_provider
    txt = "#{dsp.name} "
    if bucket.present?
      txt +=  "#{bucket}: "
    else
      txt +=  " #{ds.project_identifier}: "
    end

    if self.file_path.present?
      txt += " #{self.file_path}"
    else
      self.fileid.present?
      txt += " #{self.fileid}"
    end
    return txt
  end

  def analysis
    if self.analysis_merged_bam_file.present?
      analysis = self.analysis_merged_bam_file
    elsif self.analysis_merged_peaks_file.present?
      analysis = self.analysis_merged_peaks_file
    elsif self.analysis_merged_qc_file.present?
      analysis = self.analysis_merged_qc_file
    else
      analysis = nil
    end
    return analysis
  end

  private

  def validate_file_path
    base_path = self.data_storage.folder_base_path
    if not self.file_path.start_with?(base_path)
      self.file_path = File.join(base_path,self.file_path)
    end
  end
end
