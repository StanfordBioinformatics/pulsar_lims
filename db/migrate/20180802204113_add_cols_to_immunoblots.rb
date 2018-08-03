class AddColsToImmunoblots < ActiveRecord::Migration
  def change
    add_column :immunoblots, :primary_antibody_concentration, :float
    add_column :immunoblots, :secondary_antibody_concentration, :float
  end
end
