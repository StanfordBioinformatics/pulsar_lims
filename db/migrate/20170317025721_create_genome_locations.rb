class CreateGenomeLocations < ActiveRecord::Migration
  def change
    create_table :genome_locations do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :chromosome, index: true, foreign_key: true
      t.integer :start
      t.integer :end

      t.timestamps null: false
    end
		add_index :genome_locations, :name, unique: true
  end
end
