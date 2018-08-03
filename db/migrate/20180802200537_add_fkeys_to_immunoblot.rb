class AddFkeysToImmunoblot < ActiveRecord::Migration
  def change
    add_reference :immunoblots, :analyst, index: true
    add_reference :immunoblots, :primary_antibody, index: true
    add_reference :immunoblots, :primary_antibody_concentration, index: true
    add_reference :immunoblots, :secondary_antibody, index: true
    add_reference :immunoblots, :secondary_antibody_concentration, index: true

    add_foreign_key :immunoblots, :users, column: :analyst_id
    add_foreign_key :immunoblots, :antibodies, column: :primary_antibody_id
    add_foreign_key :immunoblots, :antibodies, column: :secondary_antibody_id
    add_foreign_key :immunoblots, :concentration_units, column: :primary_antibody_concentration_id
    add_foreign_key :immunoblots, :concentration_units, column: :secondary_antibody_concentration_id
  end
end
