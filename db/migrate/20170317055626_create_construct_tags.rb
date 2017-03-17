class CreateConstructTags < ActiveRecord::Migration
  def change
    create_table :construct_tags do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
		add_index :construct_tags, :name, unique: true
  end
end
