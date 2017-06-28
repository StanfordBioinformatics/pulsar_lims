class AddSortingBiosampleToSingleCellSorting < ActiveRecord::Migration
  def change
    add_reference :single_cell_sortings, :sorting_biosample, index: true
		add_foreign_key :single_cell_sortings, :biosamples, column: :sorting_biosample_id
  end
end
