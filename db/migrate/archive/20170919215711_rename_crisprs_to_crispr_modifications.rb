class RenameCrisprsToCrisprModifications < ActiveRecord::Migration
  def change
		rename_table :crisprs, :crispr_modifications
  end
end
