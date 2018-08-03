class RenameTableConcentrationUnitsToUnits < ActiveRecord::Migration
  def change
    rename_table :concentration_units, :units
  end
end
