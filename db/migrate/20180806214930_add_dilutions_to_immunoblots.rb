class AddDilutionsToImmunoblots < ActiveRecord::Migration
  def change
    add_column :immunoblots, :primary_antibody_dilution, :string
    add_column :immunoblots, :secondary_antibody_dilution, :string
  end
end
