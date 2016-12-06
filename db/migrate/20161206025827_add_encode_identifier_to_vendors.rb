class AddEncodeIdentifierToVendors < ActiveRecord::Migration
  def change
		add_column :vendors, :encode_identifier, :string
		add_index :vendors, :encode_identifier, unique: true
  end
end
