class RenameSequencingResultsToSequencingRuns < ActiveRecord::Migration
  def change
		rename_table :sequencing_results, :sequencing_runs
  end
end
