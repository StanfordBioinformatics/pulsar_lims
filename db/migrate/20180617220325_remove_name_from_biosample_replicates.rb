class RemoveNameFromBiosampleReplicates < ActiveRecord::Migration
  def change
    remove_column :biosample_replicates, :name
  end
end
