class RemoveFkeyEncidOnVendors < ActiveRecord::Migration
  def change
		remove_index :vendors, name: :index_vendors_on_encode_identifier
  end
end
