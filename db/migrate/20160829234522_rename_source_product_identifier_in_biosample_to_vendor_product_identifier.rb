class RenameSourceProductIdentifierInBiosampleToVendorProductIdentifier < ActiveRecord::Migration
  def change
		rename_column :biosamples, :source_product_identifier, :vendor_product_identifier
  end
end
