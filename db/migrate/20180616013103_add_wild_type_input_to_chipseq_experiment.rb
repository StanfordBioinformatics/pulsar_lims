class AddWildTypeInputToChipseqExperiment < ActiveRecord::Migration
  def change
    add_reference :chipseq_experiments, :wild_type_input, index: true
    add_foreign_key :chipseq_experiments, :biosample_replicates, column: :wild_type_input_id
  end
end
