class AddStorageLocationToSequencingRuns < ActiveRecord::Migration
  def change
    add_reference :sequencing_runs, :storage_location, index: true
		add_foreign_key :sequencing_runs, :file_references, column: :storage_location_id
  end
end
