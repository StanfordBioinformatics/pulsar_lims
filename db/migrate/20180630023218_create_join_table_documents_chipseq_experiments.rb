class CreateJoinTableDocumentsChipseqExperiments < ActiveRecord::Migration
  def change
    create_join_table :documents, :chipseq_experiments do |t|
      #t.index [:document_id, :chipseq_experiment_id]
      #t.index [:chipseq_experiment_id, :document_id]
    end
    add_index :chipseq_experiments_documents, [:document_id, :chipseq_experiment_id], name: "document_cse_idx"
    add_index :chipseq_experiments_documents, [:chipseq_experiment_id,:document_id], name: "cse_document_idx"
  end
end
