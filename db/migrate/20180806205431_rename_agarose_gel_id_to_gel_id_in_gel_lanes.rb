class RenameAgaroseGelIdToGelIdInGelLanes < ActiveRecord::Migration
  def change
    rename_column :gel_lanes, :agarose_gel_id, :gel_id
  end
end
