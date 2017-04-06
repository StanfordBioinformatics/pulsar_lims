class CreatePairedBarcodes < ActiveRecord::Migration
  def change
    create_table :paired_barcodes do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :index1
      t.references :index2
      t.references :sequencing_library_prep_kit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
