class AddLoadVolumeToGelLane < ActiveRecord::Migration
  def change
    add_column :gel_lanes, :load_volume, :string
  end
end
