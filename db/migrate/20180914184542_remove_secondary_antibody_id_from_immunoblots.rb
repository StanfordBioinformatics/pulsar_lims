class RemoveSecondaryAntibodyIdFromImmunoblots < ActiveRecord::Migration
  def change
    remove_column :immunoblots, :secondary_antibody_id, :integer
  end
end
