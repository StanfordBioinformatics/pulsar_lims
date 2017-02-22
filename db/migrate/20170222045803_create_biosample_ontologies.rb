class CreateBiosampleOntologies < ActiveRecord::Migration
  def change
    create_table :biosample_ontologies do |t|
      t.references :user, index: true
      t.string :name
      t.string :url

      t.timestamps null: false
    end
    add_index :biosample_ontologies, :name, unique: true
    add_index :biosample_ontologies, :url, unique: true
    add_foreign_key :biosample_ontologies, :users
  end
end
