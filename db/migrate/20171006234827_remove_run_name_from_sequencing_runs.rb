class RemoveRunNameFromSequencingRuns < ActiveRecord::Migration
  def change
		remove_column :sequencing_runs, :run_name
  end
end
