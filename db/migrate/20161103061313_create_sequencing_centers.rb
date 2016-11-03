class CreateSequencingCenters < ActiveRecord::Migration
  def change
    create_table :sequencing_centers do |t|
      t.string :name
      t.text :address

      t.timestamps null: false
    end
  end
end
