class AddChipseqStartingBiosampleToBiosamples < ActiveRecord::Migration
  def change
    add_reference :biosamples, :chipseq_starting_biosample, index: true
    add_foreign_key :biosamples, :chipseq_experiments, column: :chipseq_starting_biosample_id
  end
end
