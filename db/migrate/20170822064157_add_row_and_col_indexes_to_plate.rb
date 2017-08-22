class AddRowAndColIndexesToPlate < ActiveRecord::Migration
  def change
		add_index :wells, :row
		add_index :wells, :col
  end
end
