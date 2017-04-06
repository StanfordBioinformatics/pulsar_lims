class CreateJoinTableLibraryPairedBarcode < ActiveRecord::Migration
  def change
    create_join_table :libraries, :paired_barcodes do |t|
      t.integer :library_id
      t.integer :paired_barcode_id
    end
    add_index :libraries_paired_barcodes, [:library_id, :paired_barcode_id], name: "library_paired_barcode"
    add_index :libraries_paired_barcodes, [:paired_barcode_id, :library_id], name: "paired_barcode_library"
  end
end
