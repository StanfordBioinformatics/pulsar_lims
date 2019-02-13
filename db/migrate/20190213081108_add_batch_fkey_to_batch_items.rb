class AddBatchFkeyToBatchItems < ActiveRecord::Migration
  def change
    add_reference :batch_items, :batch, index: true, foreign_key: true
  end
end
