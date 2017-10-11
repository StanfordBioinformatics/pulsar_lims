class CreateFileReferences < ActiveRecord::Migration
  def change
    create_table :file_references do |t|
      t.references :user, index: true, foreign_key: true
      t.references :data_storage, index: true, foreign_key: true
      t.string :file_path
      t.string :fileid

      t.timestamps null: false
    end
  end
end
