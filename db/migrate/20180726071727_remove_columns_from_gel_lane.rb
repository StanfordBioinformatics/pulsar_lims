class RemoveColumnsFromGelLane < ActiveRecord::Migration
  def change
    remove_column :gel_lanes, :expected_product_size
    remove_column :gel_lanes, :actual_product_size
    remove_column :gel_lanes, :sample_volume
    remove_column :gel_lanes, :sample_concentration
  end
end
