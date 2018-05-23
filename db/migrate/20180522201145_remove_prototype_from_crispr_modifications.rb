class RemovePrototypeFromCrisprModifications < ActiveRecord::Migration
  def change
    remove_column :crispr_modifications, :prototype
  end
end
