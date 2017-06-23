class RemoveBarcodeIdAndPairedBarcodeIdFromWell < ActiveRecord::Migration
  def change
		remove_column :wells, :barcode_id
		remove_column :wells, :paired_barcode_id
  end
end
