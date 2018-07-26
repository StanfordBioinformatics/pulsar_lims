class AddUserToGelLane < ActiveRecord::Migration
  def change
    add_reference :gel_lanes, :user, index: true, foreign_key: true
  end
end
