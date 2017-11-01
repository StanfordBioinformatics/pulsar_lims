class CreatePcrValidations < ActiveRecord::Migration
  def change
    create_table :pcr_validations do |t|
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.references :pcr_master_mix, index: true, foreign_key: true
      t.string :forward_primer
      t.string :reverse_primer
      t.integer :amplicon_size
      t.float :annealing_temperature
      t.integer :extension_time
      t.integer :num_cycles
      t.references :crispr_modification, index: true, foreign_key: true
      t.boolean :success

      t.timestamps null: false
    end
  end
end
