class AddVendorToCloningVectors < ActiveRecord::Migration
  def change
    add_reference :cloning_vectors, :vendor, index: true, foreign_key: true
    add_column :cloning_vectors, :vendor_product_identifier, :string, unique: true
  end
end
