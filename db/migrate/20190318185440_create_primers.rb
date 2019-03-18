class CreatePrimers < ActiveRecord::Migration
  def change
    create_table :primers do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.text :notes
      t.string :direction
      t.string :sequence
      t.string :melting_temperature
      t.date :date_ordered

      t.timestamps null: false
    end
  end
end
