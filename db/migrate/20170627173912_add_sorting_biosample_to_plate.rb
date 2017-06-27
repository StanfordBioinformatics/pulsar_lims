class AddSortingBiosampleToPlate < ActiveRecord::Migration
  def change
    add_reference :plates, :sorting_biosample, index: true
		add_foreign_key :plates, :biosamples, column: :sorting_biosample_id
  end
end
