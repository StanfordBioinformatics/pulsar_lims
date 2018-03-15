class CreateJoinTableDocumentSingleCellSorting < ActiveRecord::Migration
  def change
    create_join_table :documents, :single_cell_sortings do |t|
       #t.index [:document_id, :single_cell_sorting_id]
       #t.index [:single_cell_sorting_id, :document_id]
    end
    add_index :documents_single_cell_sortings, [:document_id, :single_cell_sorting_id], name: "document_scs_idx"
    add_index :documents_single_cell_sortings, [:single_cell_sorting_id,:document_id], name: "scs_document_idx"
  end
end
