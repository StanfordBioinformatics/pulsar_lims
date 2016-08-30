class CreateAntibodyAntibodyPurificationJoinTable < ActiveRecord::Migration
  def change
    create_table :antibodies_antibody_purifications, id: false do |t| 
      t.integer :antibody_id, index: true
      t.integer :antibody_purification_id, index: true
    end 
  end
end
