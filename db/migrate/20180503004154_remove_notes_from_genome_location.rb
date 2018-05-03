class RemoveNotesFromGenomeLocation < ActiveRecord::Migration
  def change
    remove_column :genome_locations, :notes
  end
end
