class RenameWildTypeInputToWildTypeControlInChipseqExperiments < ActiveRecord::Migration
  def change
    rename_column :chipseq_experiments, :wild_type_input_id, :wild_type_control_id
  end
end
