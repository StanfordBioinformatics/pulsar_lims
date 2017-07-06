class RemoveUniqueNameIndexOnPlates < ActiveRecord::Migration
  def change
		remove_index :plates, :name
  end
end
