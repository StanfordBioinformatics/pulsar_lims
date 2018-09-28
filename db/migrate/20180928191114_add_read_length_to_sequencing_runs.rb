class AddReadLengthToSequencingRuns < ActiveRecord::Migration
  def change
    add_column :sequencing_runs, :forward_read_len, :integer
    add_column :sequencing_runs, :reverse_read_len, :integer
  end
end
