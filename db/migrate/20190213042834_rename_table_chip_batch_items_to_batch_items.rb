class RenameTableChipBatchItemsToBatchItems < ActiveRecord::Migration
  def change
    rename_table :chip_batch_items, :batch_items
  end
end
