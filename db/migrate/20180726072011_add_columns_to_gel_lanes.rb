class AddColumnsToGelLanes < ActiveRecord::Migration
  def change
    add_column :gel_lanes, :expected_product_size, :float
    add_column :gel_lanes, :actual_product_size, :float
    add_column :gel_lanes, :sample_volume, :float
    add_column :gel_lanes, :sample_concentration, :float
  end
end
