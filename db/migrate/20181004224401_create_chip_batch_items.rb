class CreateChipBatchItems < ActiveRecord::Migration
  def change
    create_table :chip_batch_items do |t|
      t.references :user, index: true, foreign_key: true
      t.references :chip_batch, index: true, foreign_key: true
      t.references :biosample, index: true, foreign_key: true
      t.string :concentration
      t.text :notes

      t.timestamps null: false
    end
  end
end
