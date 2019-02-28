class AddUpstreamIdentifierToGelLanes < ActiveRecord::Migration
  def change
    add_column :gel_lanes, :upstream_identifier, :string
  end
end
