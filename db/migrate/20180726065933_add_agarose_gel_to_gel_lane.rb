class AddAgaroseGelToGelLane < ActiveRecord::Migration
  def change
    add_reference :gel_lanes, :agarose_gel, index: true, foreign_key: true
  end
end
