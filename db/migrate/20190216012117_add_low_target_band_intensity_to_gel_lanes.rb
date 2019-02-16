class AddLowTargetBandIntensityToGelLanes < ActiveRecord::Migration
  def change
    add_column :gel_lanes, :low_target_band_intensity, :boolean
  end
end
