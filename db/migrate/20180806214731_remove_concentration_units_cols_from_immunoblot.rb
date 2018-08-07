class RemoveConcentrationUnitsColsFromImmunoblot < ActiveRecord::Migration
  def change
    remove_column :immunoblots, :primary_antibody_concentration_units_id
    remove_column :immunoblots, :secondary_antibody_concentration_units_id
  end
end
