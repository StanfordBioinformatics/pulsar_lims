class RemoveStorageLocationFromSequencingRun < ActiveRecord::Migration
  def change
    remove_column :sequencing_runs, :storage_location_id, :integer
  end
end
