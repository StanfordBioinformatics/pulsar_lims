class RemoveBiosampleIdFromCrisprModification < ActiveRecord::Migration
  def change
    remove_column :crispr_modifications, :biosample_id
  end
end
