class CreateSequencingRequests < ActiveRecord::Migration
  def change
    create_table :sequencing_requests do |t|
      t.string :name
      t.text :comment
      t.references :sequencing_platform, index: true
      t.references :sequencing_center, index: true
      t.boolean :shipped

      t.timestamps null: false
    end
    add_foreign_key :sequencing_requests, :sequencing_platforms
    add_foreign_key :sequencing_requests, :sequencing_centers
  end
end
