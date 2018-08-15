class DropTableBiosampleReplicates < ActiveRecord::Migration
  def change
    drop_table :biosample_replicates
  end
end
