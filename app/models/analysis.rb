class Analysis < ActiveRecord::Base
  belongs_to :user
	belongs_to :merged_bam_file, class_name: "FileReference"
	belongs_to :merged_peaks_file, class_name: "FileReference"
	belongs_to :merged_qc_file, class_name: "FileReference"
	belongs_to :single_cell_sorting

	accepts_nested_attributes_for :merged_bam_file, allow_destroy: true
	accepts_nested_attributes_for :merged_peaks_file, allow_destroy: true
	accepts_nested_attributes_for :merged_qc_file, allow_destroy: true

	def self.policy_class
		ApplicationPolicy
	end
end
