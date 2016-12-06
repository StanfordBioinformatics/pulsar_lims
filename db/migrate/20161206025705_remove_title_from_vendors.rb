class RemoveTitleFromVendors < ActiveRecord::Migration
  def change
		remove_column :vendors, :title
  end
end
