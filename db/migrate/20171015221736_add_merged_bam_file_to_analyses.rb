class AddMergedBamFileToAnalyses < ActiveRecord::Migration
  def change
    add_reference :analyses, :merged_bam_file, index: true
		add_foreign_key :analyses, :file_references, column: :merged_bam_file_id
  end
end
