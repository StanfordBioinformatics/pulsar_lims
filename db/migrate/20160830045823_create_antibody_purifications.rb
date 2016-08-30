class CreateAntibodyPurifications < ActiveRecord::Migration
  def change
    create_table :antibody_purifications do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
