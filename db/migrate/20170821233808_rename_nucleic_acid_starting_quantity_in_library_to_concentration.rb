class RenameNucleicAcidStartingQuantityInLibraryToConcentration < ActiveRecord::Migration
  def change
		rename_column :libraries, :nucleic_acid_starting_quantity, :concentration
  end
end
