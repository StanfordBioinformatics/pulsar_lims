class CreateJoinTableDocumentsCrisprModifications < ActiveRecord::Migration
  def change
    create_join_table :documents, :crispr_modifications do |t|
      #t.index [:document_id, :crispr_modification_id]
      #t.index [:crispr_modification_id, :document_id]
    end
    add_index :crispr_modifications_documents, [:document_id, :crispr_modification_id], name: "document_cmod_idx"
    add_index :crispr_modifications_documents, [:crispr_modification_id,:document_id], name: "cmod_document_idx"
  end
end
