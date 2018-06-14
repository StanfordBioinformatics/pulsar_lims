class CreateBiosampleReplicates < ActiveRecord::Migration
  def change
    create_table :biosample_replicates do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :upstream_identifier
      t.integer :biological_replicate_number
      t.integer :technical_replicate_number
      t.text :notes

      t.timestamps null: false
    end
  end
end
