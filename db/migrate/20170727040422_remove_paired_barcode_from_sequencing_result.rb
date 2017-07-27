class RemovePairedBarcodeFromSequencingResult < ActiveRecord::Migration
  def change
		remove_column :sequencing_results, :paired_barcode_id
  end
end
