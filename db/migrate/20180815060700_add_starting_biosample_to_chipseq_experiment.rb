class AddStartingBiosampleToChipseqExperiment < ActiveRecord::Migration
  def change
    add_reference :chipseq_experiments, :starting_biosample, index: true
    add_foreign_key :chipseq_experiments, :biosamples, column: :starting_biosample_id
  end
end
