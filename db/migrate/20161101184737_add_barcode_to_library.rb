class AddBarcodeToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :barcode, :string
  end
end
