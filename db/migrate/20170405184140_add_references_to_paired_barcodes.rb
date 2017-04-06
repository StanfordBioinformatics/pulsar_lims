class AddReferencesToPairedBarcodes < ActiveRecord::Migration
  def change
		add_index :paired_barcodes, :index1_id
		add_index :paired_barcodes, :index2_id
		add_foreign_key :paired_barcodes, :barcodes, column: :index1_id
		add_foreign_key :paired_barcodes, :barcodes, column: :index2_id
  end
end
