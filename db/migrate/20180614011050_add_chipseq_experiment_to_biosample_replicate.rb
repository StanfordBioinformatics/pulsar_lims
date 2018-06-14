class AddChipseqExperimentToBiosampleReplicate < ActiveRecord::Migration
  def change
    add_reference :biosample_replicates, :chipseq_experiment, index: true, foreign_key: true
  end
end
