class AddBiosampleToBiosampleReplicates < ActiveRecord::Migration
  def change
    add_reference :biosample_replicates, :biosample, index: true, foreign_key: true
  end
end
