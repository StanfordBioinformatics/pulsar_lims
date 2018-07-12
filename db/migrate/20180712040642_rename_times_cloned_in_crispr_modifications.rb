class RenameTimesClonedInCrisprModifications < ActiveRecord::Migration
  def change
    rename_column :crispr_modifications, :_times_cloned, :times_cloned
  end
end
