class CreateJoinTableDocumentsDonorConstructs < ActiveRecord::Migration
  def change
    create_join_table :documents, :donor_constructs do |t|
      t.integer :document_id
      t.integer :donor_construct_id
    end
    add_index :documents_donor_constructs, [:document_id, :donor_construct_id], name: :doc_donor_construct_idx
    add_index :documents_donor_constructs, [:donor_construct_id, :document_id], name: :donor_construct_doc_idx
  end
end
