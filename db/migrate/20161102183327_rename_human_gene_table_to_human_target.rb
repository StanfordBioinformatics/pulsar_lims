class RenameHumanGeneTableToHumanTarget < ActiveRecord::Migration
  def change
		rename_table(:human_genes,:human_targets)
  end
end
