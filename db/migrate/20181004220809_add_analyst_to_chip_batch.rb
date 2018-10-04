class AddAnalystToChipBatch < ActiveRecord::Migration
  def change
    add_reference :chip_batches, :analyst, index: true
    add_foreign_key :chip_batches, :users, column: :analyst_id
  end
end
