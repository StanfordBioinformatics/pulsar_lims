class RemoveAntibodyFromChipBatchItem < ActiveRecord::Migration
  def change
    remove_column :chip_batch_items, :antibody_id
  end
end
