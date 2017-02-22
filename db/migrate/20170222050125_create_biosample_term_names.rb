class CreateBiosampleTermNames < ActiveRecord::Migration
  def change
    create_table :biosample_term_names do |t|
      t.references :user, index: true
      t.string :name
      t.string :accession
      t.references :biosample_ontology, index: true
      t.text :description

      t.timestamps null: false
    end
    add_index :biosample_term_names, :name, unique: true
    add_foreign_key :biosample_term_names, :users
    add_foreign_key :biosample_term_names, :biosample_ontologies
  end
end
