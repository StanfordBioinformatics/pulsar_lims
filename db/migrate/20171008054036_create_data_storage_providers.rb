class CreateDataStorageProviders < ActiveRecord::Migration
  def change
    create_table :data_storage_providers do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
