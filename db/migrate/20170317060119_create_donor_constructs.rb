class CreateDonorConstructs < ActiveRecord::Migration
  def change
    create_table :donor_constructs do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :cloning_vector, index: true, foreign_key: true
      t.references :vendor, index: true, foreign_key: true
      t.string :vendor_product_identifier
      t.references :target, index: true, foreign_key: true
      t.text :description
      t.text :insert_sequence

      t.timestamps null: false
    end
		add_index :donor_constructs, :name, unique: true
  end
end
