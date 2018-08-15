class AddWildTypeInputToChipseqExperiments < ActiveRecord::Migration
  def change
    add_reference :chipseq_experiments, :wild_type_input, index: true
    add_foreign_key :chipseq_experiments, :biosamples, column: :wild_type_input_id
  end
end
