class CreateCrisprConstructs < ActiveRecord::Migration
  def change
    create_table :crispr_constructs do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :target, index: true, foreign_key: true
      t.text :guide_sequence
      t.references :cloning_vector, index: true, foreign_key: true
      t.text :description
      t.references :vendor, index: true, foreign_key: true
      t.string :vendor_product_identifier

      t.timestamps null: false
    end
		add_index :crispr_constructs, :name, unique: true
  end
end
