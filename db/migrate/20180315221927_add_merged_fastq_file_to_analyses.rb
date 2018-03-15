class AddMergedFastqFileToAnalyses < ActiveRecord::Migration
  def change
    add_reference :analyses, :merged_fastq_file, index: true
    add_foreign_key :analyses, :file_references, column: :merged_fastq_file_id
  end
end
