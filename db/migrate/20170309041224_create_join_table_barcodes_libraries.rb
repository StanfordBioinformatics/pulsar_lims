class CreateJoinTableBarcodesLibraries < ActiveRecord::Migration
  def change
    create_join_table :barcodes, :libraries do |t|
      t.index :barcode_id
      t.index :library_id
    end
  end
end
