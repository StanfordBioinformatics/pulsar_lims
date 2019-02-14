class CreateAtacseqs < ActiveRecord::Migration
  def change
    create_table :atacseqs do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.text :submitter_comments
      t.text :notes

      t.timestamps null: false
    end
  end
end
