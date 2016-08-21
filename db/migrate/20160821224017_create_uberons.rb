class CreateUberons < ActiveRecord::Migration
  def change
    create_table :uberons do |t|
      t.string :name
      t.string :accession

      t.timestamps
    end
  end
end
