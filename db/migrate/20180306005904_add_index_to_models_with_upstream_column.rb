class AddIndexToModelsWithUpstreamColumn < ActiveRecord::Migration
  def change
    add_index :antibodies, :upstream, unique: true
    add_index :crispr_modifications, :upstream, unique: true
    add_index :documents, :upstream, unique: true
    add_index :libraries, :upstream, unique: true
    add_index :sequencing_platforms, :upstream, unique: true
    add_index :single_cell_sortings, :upstream, unique: true
    add_index :treatments, :upstream, unique: true
    add_index :donors, :upstream, unique: true
  end
end
