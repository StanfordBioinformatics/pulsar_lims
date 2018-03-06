class AddUpstreamToBiosampleAndVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :upstream, :string
    add_column :biosamples, :upstream, :string
    add_index :vendors, :upstream, unique: true
    add_index :biosamples, :upstream, unique: true
  end
end
