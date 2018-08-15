class AddChipseqExperimentIdToBiosamples < ActiveRecord::Migration
  def change
    add_reference :biosamples, :chipseq_experiment, index: true, foreign_key: true
  end
end
