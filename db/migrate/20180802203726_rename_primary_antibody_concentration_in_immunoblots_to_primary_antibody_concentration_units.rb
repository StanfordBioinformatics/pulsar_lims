class RenamePrimaryAntibodyConcentrationInImmunoblotsToPrimaryAntibodyConcentrationUnits < ActiveRecord::Migration
  def change
    rename_column :immunoblots, :primary_antibody_concentration_id, :primary_antibody_concentration_units_id
    rename_column :immunoblots, :secondary_antibody_concentration_id, :secondary_antibody_concentration_units_id
  end
end
