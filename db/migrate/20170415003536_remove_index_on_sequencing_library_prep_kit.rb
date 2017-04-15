class RemoveIndexOnSequencingLibraryPrepKit < ActiveRecord::Migration
  def change
		remove_index :sequencing_library_prep_kits, name: :vendor_vendor_product_indentifier
  end
end
