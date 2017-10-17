class AddSingleCellSortingFkeyToAnalyses < ActiveRecord::Migration
  def change
    add_reference :analyses, :single_cell_sorting, index: true, foreign_key: true
  end
end
