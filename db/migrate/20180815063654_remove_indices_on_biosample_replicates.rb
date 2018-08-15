class RemoveIndicesOnBiosampleReplicates < ActiveRecord::Migration
  def change
    remove_index :biosample_replicates, name: :index_biosample_replicates_on_biosample_id
    remove_index :biosample_replicates, name: :index_biosample_replicates_on_chipseq_experiment_id
    remove_index :biosample_replicates, name: :index_biosample_replicates_on_name
    remove_index :biosample_replicates, name: :index_biosample_replicates_on_user_id
  end
end
