class CreateAntibodies < ActiveRecord::Migration
  def change
    create_table :antibodies do |t|
      t.references :organism, index: true
      t.references :antibody_purifications, index: true
      t.references :vendor, index: true
      t.references :isotype, index: true
      t.references :human_gene, index: true
      t.string :vendor_product_identifier
      t.string :vendor_product_url
      t.string :lot_identifier
      t.string :clonality
      t.string :antigen_description
      t.string :antigen_sequence

      t.timestamps
    end
  end
end
