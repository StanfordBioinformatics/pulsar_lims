class AddBatchTypeToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :batch_type, :string
  end
end
