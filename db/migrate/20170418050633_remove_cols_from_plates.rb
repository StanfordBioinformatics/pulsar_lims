class RemoveColsFromPlates < ActiveRecord::Migration
  def change
		remove_column :plates, :num_rows
		remove_column :plates, :num_cols
  end
end
