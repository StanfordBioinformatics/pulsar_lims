class AddDimensionsToPlates < ActiveRecord::Migration
  def change
    add_column :plates, :dimensions, :string
  end
end
