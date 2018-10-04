class CreateChipBatches < ActiveRecord::Migration
  def change
    create_table :chip_batches do |t|
      t.references :user, index: true, foreign_key: true
      t.string :crosslinking_method
      t.date :date

      t.timestamps null: false
    end
  end
end
