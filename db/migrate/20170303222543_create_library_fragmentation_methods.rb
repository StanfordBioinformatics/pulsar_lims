class CreateLibraryFragmentationMethods < ActiveRecord::Migration
  def change
    create_table :library_fragmentation_methods do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
