class AddLibraryPrototypeToSingleCellSorting < ActiveRecord::Migration
  def change
    add_reference :single_cell_sortings, :library_prototype, index: true
		add_foreign_key :single_cell_sortings, :libraries, column: :library_prototype_id
  end
end
