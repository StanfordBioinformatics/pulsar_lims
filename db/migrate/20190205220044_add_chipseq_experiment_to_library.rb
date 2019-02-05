class AddChipseqExperimentToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :chipseq_experiment, index: true, foreign_key: true
  end
end
