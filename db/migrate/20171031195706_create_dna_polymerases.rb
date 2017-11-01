class CreateDnaPolymerases < ActiveRecord::Migration
  def change
    create_table :dna_polymerases do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :vendor, index: true, foreign_key: true
      t.string :vendor_product_identifier
      t.string :vendor_product_url

      t.timestamps null: false
    end
  end
end
