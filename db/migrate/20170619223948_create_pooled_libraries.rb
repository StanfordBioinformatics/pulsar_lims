class CreatePooledLibraries < ActiveRecord::Migration
  def change
    create_table :pooled_libraries do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.boolean :paired_end
      t.references :sequencing_library_prep_kit, index: true, foreign_key: true
      t.string :size_range

      t.timestamps null: false
    end
  end
end
