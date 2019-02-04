class AddAntibodyToChipBatchItem < ActiveRecord::Migration
  def change
    add_reference :chip_batch_items, :antibody, index: true, foreign_key: true
  end
end
