class CreateCrisprGeneticModifications < ActiveRecord::Migration
  def change
    create_table :crispr_genetic_modifications do |t|
      t.string :name
      t.references :user, index: true
      t.references :vendor, index: true
      t.string :vendor_product_identifier
      t.text :guide_rna_sequences
      t.string :insert_sequence

      t.timestamps null: false
    end
    add_foreign_key :crispr_genetic_modifications, :users
    add_foreign_key :crispr_genetic_modifications, :vendors
  end
end
