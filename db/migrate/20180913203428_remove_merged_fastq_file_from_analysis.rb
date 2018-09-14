class RemoveMergedFastqFileFromAnalysis < ActiveRecord::Migration
  def change
    remove_column :analyses, :merged_fastq_file_id, :integer
  end
end
