class RemoveNameFromBarcodeSequencingResults < ActiveRecord::Migration
  def change
		remove_column :barcode_sequencing_results, :name, :string
  end
end
