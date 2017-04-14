class AddCompoundIndexToPairedBarcode < ActiveRecord::Migration
  def change
		add_index :paired_barcodes, [:sequencing_library_prep_kit_id, :index1_id, :index2_id], :unique => true, :name => "kit_index1_index2"
  end
end
