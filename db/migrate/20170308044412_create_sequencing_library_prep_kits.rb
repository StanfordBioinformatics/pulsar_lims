class CreateSequencingLibraryPrepKits < ActiveRecord::Migration
  def change
    create_table :sequencing_library_prep_kits do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.references :vendor, index: true, foreign_key: true
      t.text :description

      t.timestamps null: false
    end
		add_index :sequencing_library_prep_kits, [:vendor_id, :name], unique: true
  end
end
