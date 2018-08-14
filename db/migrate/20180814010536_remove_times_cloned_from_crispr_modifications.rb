class RemoveTimesClonedFromCrisprModifications < ActiveRecord::Migration
  def change
    remove_column :crispr_modifications, :times_cloned
  end
end
