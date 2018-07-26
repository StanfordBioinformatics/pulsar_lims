class CreateGelLanes < ActiveRecord::Migration
  def change
    create_table :gel_lanes do |t|
      t.integer :lane_number
      t.string :expected_product_size
      t.string :actual_product_size
      t.boolean :pass
      t.text :submitter_comments
      t.text :notes

      t.timestamps null: false
    end
  end
end
