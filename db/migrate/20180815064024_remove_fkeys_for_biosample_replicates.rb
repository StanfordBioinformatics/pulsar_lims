class RemoveFkeysForBiosampleReplicates < ActiveRecord::Migration
  def change
    remove_foreign_key :biosample_replicates, :biosamples
    remove_foreign_key :biosample_replicates, :chipseq_experiments
    remove_foreign_key :biosample_replicates, :users
  end
end
