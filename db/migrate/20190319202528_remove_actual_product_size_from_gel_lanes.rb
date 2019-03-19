class RemoveActualProductSizeFromGelLanes < ActiveRecord::Migration
  def change
    remove_column :gel_lanes, :actual_product_size
  end
end
