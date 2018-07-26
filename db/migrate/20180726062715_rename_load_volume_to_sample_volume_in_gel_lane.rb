class RenameLoadVolumeToSampleVolumeInGelLane < ActiveRecord::Migration
  def change
    rename_column :gel_lanes, :load_volume, :sample_volume
  end
end
