class RemoveSortingBiosampleFromPlate < ActiveRecord::Migration
  def change
		remove_column :plates, :sorting_biosample_id
  end
end
