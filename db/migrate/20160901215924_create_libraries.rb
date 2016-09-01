class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.references :sequence_ontology_term, index: true
      t.references :biosample, index: true
      t.references :antibody, index: true
      t.references :vendor, index: true
      t.string :lot_identifier
      t.string :vendor_product_identifier
      t.string :size_range
      t.boolean :strand_specificity

      t.timestamps
    end
  end
end
