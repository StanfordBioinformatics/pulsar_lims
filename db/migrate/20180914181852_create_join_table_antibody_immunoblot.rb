class CreateJoinTableAntibodyImmunoblot < ActiveRecord::Migration
  def change
    create_table :immunoblots_secondary_antibodies, id: false do |t|
      t.integer :immunoblot_id
      t.integer :secondary_antibody_id
    end
    add_index :immunoblots_secondary_antibodies, [:immunoblot_id, :secondary_antibody_id], name: "immunoblot_secondaryab_idx"
    add_index :immunoblots_secondary_antibodies, [:secondary_antibody_id, :immunoblot_id], name: "secondaryab_immunoblot_idx"
  end
end
