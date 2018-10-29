class RemoveUniqueIndexOnNameInSequencingRuns < ActiveRecord::Migration
  def change
    remove_index :sequencing_runs, :name
    add_index :sequencing_runs, :name
  end
end
