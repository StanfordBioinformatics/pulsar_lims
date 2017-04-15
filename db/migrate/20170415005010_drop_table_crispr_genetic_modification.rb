class DropTableCrisprGeneticModification < ActiveRecord::Migration
  def change
		drop_table :crispr_genetic_modifications
  end
end
