class CreateDataFileTypes < ActiveRecord::Migration
  def change
    create_table :data_file_types do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
