class AddReadStatsToSequencingResults < ActiveRecord::Migration
  def change
    add_column :sequencing_results, :read2_aligned_perc, :float
    add_column :sequencing_results, :read1_aligned_perc, :float
    add_column :sequencing_results, :pair_aligned_perc, :float
    add_column :sequencing_results, :mapper, :string
  end
end
