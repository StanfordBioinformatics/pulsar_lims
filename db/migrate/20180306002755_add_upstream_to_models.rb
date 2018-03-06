class AddUpstreamToModels < ActiveRecord::Migration
  def change
    add_column :antibodies, :upstream, :string
    add_column :crispr_modifications, :upstream, :string
    add_column :documents, :upstream, :string
    add_column :libraries, :upstream, :string
    add_column :sequencing_platforms, :upstream, :string
    add_column :single_cell_sortings, :upstream, :string
    add_column :treatments, :upstream, :string
  end
end
