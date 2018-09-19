class AddDataStorageToSequencingRuns < ActiveRecord::Migration
  def change
    add_reference :sequencing_runs, :data_storage, index: true, foreign_key: true
  end
end
