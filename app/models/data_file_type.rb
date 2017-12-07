class DataFileType < ActiveRecord::Base
	DEFINITION = "A file containing raw data or analysis results, i.e. FASTQ, BAM, BED, VCF, TSV."
  belongs_to :user
	has_many :file_references

	validates :name, presence: true, uniqueness: true

  def self.policy_class
    ApplicationPolicy
  end 

end
