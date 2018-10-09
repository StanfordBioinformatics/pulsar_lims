class AddNotesToChipBatch < ActiveRecord::Migration
  def change
    add_column :chip_batches, :notes, :text
  end
end
