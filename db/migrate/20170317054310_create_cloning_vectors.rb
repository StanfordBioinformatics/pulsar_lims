class CreateCloningVectors < ActiveRecord::Migration
  def change
    create_table :cloning_vectors do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :url

      t.timestamps null: false
    end
		add_index :cloning_vectors, :name, unique: true
  end
end
