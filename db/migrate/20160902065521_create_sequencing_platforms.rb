class CreateSequencingPlatforms < ActiveRecord::Migration
  def change
    create_table :sequencing_platforms do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
