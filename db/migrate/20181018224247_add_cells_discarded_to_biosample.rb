class AddCellsDiscardedToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :cells_discarded, :boolean, default: false
  end
end
