class AddBarcodeToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :barcode, index: true, foreign_key: true
  end
end
