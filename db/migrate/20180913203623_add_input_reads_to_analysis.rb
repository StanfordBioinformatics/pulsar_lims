class AddInputReadsToAnalysis < ActiveRecord::Migration
  def change
    add_reference :analyses, :input_reads, index: true
    add_foreign_key :analyses, :sequencing_results, column: :input_reads_id
  end
end
