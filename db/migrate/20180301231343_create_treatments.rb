class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :treatment_term_name, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :treatment_type
      t.float :concentration
      t.references :concentration_unit, index: true, foreign_key: true
      t.float :duration
      t.string :duration_units
      t.float :temperature

      t.timestamps null: false
    end
  end
end
