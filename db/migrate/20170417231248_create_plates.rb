class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.references :sequencing_library_prep_kit, index: true, foreign_key: true
      t.boolean :paired_end
      t.integer :num_rows
      t.integer :num_cols
      t.references :vendor, index: true, foreign_key: true
      t.string :vendor_product_identifier

      t.timestamps null: false
    end
		add_index :plates, :name, unique: true
  end
end
