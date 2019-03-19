class AddNeedsAdditionalPcrToGelLanes < ActiveRecord::Migration
  def change
    add_column :gel_lanes, :needs_additional_pcr, :boolean
  end
end
