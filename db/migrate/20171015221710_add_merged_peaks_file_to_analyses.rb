class AddMergedPeaksFileToAnalyses < ActiveRecord::Migration
  def change
    add_reference :analyses, :merged_peaks_file, index: true
		add_foreign_key :analyses, :file_references, column: :merged_peaks_file_id
  end
end
