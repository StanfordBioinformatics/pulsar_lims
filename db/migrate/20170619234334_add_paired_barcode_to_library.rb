class AddPairedBarcodeToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :paired_barcode, index: true, foreign_key: true
  end
end
