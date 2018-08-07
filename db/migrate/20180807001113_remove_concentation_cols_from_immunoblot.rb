class RemoveConcentationColsFromImmunoblot < ActiveRecord::Migration
  def change
    remove_column :immunoblots, :primary_antibody_concentration
    remove_column :immunoblots, :secondary_antibody_concentration
  end
end
