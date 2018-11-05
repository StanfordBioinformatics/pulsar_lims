class RemoveStartingBiosampleFromChipseqExperiment < ActiveRecord::Migration
  def change
    remove_column :chipseq_experiments, :starting_biosample_id, :integer
  end
end
