class AddVendorVendorIdentifierIndexOnSequencingLibraryPrepKit < ActiveRecord::Migration
  def change
		add_index :sequencing_library_prep_kits, [:vendor_id, :vendor_product_identifier], :unique => true, :name => "vendor_vendor_product_indentifier"
  end
end
