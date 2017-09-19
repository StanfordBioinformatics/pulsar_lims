class RemoveJoinTableBarcodesLibraries < ActiveRecord::Migration
  def change
		drop_table :barcodes_libraries
  end
end
