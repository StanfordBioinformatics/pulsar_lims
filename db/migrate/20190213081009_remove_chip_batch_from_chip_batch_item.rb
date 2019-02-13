class RemoveChipBatchFromChipBatchItem < ActiveRecord::Migration
  def change
    remove_column :batch_items, :chip_batch_id
  end
end
