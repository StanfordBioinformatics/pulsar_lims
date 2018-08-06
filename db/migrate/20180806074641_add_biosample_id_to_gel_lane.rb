class AddBiosampleIdToGelLane < ActiveRecord::Migration
  def change
    add_reference :gel_lanes, :biosample, index: true, foreign_key: true
  end
end
