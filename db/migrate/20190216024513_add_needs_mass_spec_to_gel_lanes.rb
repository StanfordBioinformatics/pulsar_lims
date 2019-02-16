class AddNeedsMassSpecToGelLanes < ActiveRecord::Migration
  def change
    add_column :gel_lanes, :needs_mass_spec, :boolean
  end
end
