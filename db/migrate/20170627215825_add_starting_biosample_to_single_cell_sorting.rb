class AddStartingBiosampleToSingleCellSorting < ActiveRecord::Migration
  def change
    add_reference :single_cell_sortings, :starting_biosample, index: true
		add_foreign_key :single_cell_sortings, :biosamples, column: :starting_biosample_id
  end
end
