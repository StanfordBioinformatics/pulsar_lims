class AddUpstreamIndexOnRemainingTables < ActiveRecord::Migration
  def change
    remove_column :vendors, :upstream
    remove_column :biosamples, :upstream
#    add_column :vendors, :upstream
#    add_column :biosamples, :upstream
#    add_index :vendors, :upstream, unique: true
#    add_index :biosamples, :upstream, unique: true
  end
end
