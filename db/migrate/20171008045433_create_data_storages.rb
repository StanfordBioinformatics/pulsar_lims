class CreateDataStorages < ActiveRecord::Migration
  def change
    create_table :data_storages do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :bucket
      t.string :project_identifier
      t.string :folder_base_path

      t.timestamps null: false
    end
  end
end
