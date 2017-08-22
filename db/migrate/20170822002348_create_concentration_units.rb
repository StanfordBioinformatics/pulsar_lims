class CreateConcentrationUnits < ActiveRecord::Migration
  def change
    create_table :concentration_units do |t|
      t.string :name, unique: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
