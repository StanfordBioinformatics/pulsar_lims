class AddSingleCellSortingToPlate < ActiveRecord::Migration
  def change
    add_reference :plates, :single_cell_sorting, index: true, foreign_key: true
  end
end
