class CreateJoinTableCrisprConstructsDocuments < ActiveRecord::Migration
  def change
    create_join_table :crispr_constructs, :documents do |t|
      t.integer :crispr_construct_id
      t.integer :document_id
    end
    add_index :crispr_constructs_documents, [:crispr_construct_id, :document_id], name: :cc_doc_idx
    add_index :crispr_constructs_documents, [:document_id, :crispr_construct_id], name: :doc_cc_idx
  end
end
