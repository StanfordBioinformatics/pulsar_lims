class RemoveUpstreamFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :upstream
  end
end
