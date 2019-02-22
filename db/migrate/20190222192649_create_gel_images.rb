class CreateGelImages < ActiveRecord::Migration
  def change
    create_table :gel_images do |t|
      t.references :user, index: true, foreign_key: true
      t.references :gel, index: true, foreign_key: true
      t.integer :film_exposure_time
      t.string :image

      t.timestamps null: false
    end
  end
end
