class CreateBarcodes < ActiveRecord::Migration
  def change
    create_table :barcodes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :sequencing_library_prep_kit, index: true, foreign_key: true
      t.string :name
      t.string :sequence

      t.timestamps null: false
    end
  end
end
