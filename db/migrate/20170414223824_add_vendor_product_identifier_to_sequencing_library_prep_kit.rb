class AddVendorProductIdentifierToSequencingLibraryPrepKit < ActiveRecord::Migration
  def change
    add_column :sequencing_library_prep_kits, :vendor_product_identifier, :string
  end
end
