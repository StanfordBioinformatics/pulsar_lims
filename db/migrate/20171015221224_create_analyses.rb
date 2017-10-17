class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.references :user, index: true, foreign_key: true
      t.text :description

      t.timestamps null: false
    end
  end
end
