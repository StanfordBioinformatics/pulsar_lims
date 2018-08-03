class RenameTypeInUnitsToUnitType < ActiveRecord::Migration
  def change
    rename_column :units, :type, :unit_type
  end
end
