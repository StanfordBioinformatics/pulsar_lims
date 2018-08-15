class RemoveWildTypeInputFromChipseqExperiments < ActiveRecord::Migration
  def change
    remove_column :chipseq_experiments, :wild_type_input_id
  end
end
