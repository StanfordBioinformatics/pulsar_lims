class AddMergedQcFileToAnalyses < ActiveRecord::Migration
  def change
    add_reference :analyses, :merged_qc_file, index: true
		add_foreign_key :analyses, :file_references, column: :merged_qc_file_id
  end
end
