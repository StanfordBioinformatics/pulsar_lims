class RemoveDataStorageIdFromSequencingRuns < ActiveRecord::Migration
  def change
    remove_column :sequencing_runs, :data_storage_id
  end
end
