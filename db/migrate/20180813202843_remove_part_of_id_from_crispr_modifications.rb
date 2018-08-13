class RemovePartOfIdFromCrisprModifications < ActiveRecord::Migration
  def change
    remove_column :crispr_modifications, :part_of_id 
  end
end
