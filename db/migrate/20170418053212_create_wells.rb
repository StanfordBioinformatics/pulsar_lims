class CreateWells < ActiveRecord::Migration
  def change
    create_table :wells do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.references :plate, index: true, foreign_key: true
      t.integer :row
      t.integer :col
      t.references :barcode, index: true, foreign_key: true
      t.references :paired_barcode, index: true, foreign_key: true
      t.boolean :fail, default: false
      t.text :comment

      t.timestamps null: false
    end
  end
end
