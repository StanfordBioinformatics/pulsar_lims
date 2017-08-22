class RemoveNucleicAcidStartingQuantityUnitsFromLibrary < ActiveRecord::Migration
  def change
		remove_column :libraries, :nucleic_acid_starting_quantity_units
  end
end
