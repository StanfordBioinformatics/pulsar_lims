class RemoveBarcodeFromSequencingResult < ActiveRecord::Migration
  def change
		remove_column :sequencing_results, :barcode_id
  end
end
