class AddIndexToNameInVendor < ActiveRecord::Migration
  def change
		add_index :vendors, :name, unique: true
  end
end
