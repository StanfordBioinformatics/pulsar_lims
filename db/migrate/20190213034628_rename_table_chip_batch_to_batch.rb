class RenameTableChipBatchToBatch < ActiveRecord::Migration
  def change
    rename_table :chip_batches, :batches
  end
end
