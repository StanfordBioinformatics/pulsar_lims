class RemoveNameFromGenomeLocations < ActiveRecord::Migration
  def change
		remove_column :genome_locations, :name
  end
end
