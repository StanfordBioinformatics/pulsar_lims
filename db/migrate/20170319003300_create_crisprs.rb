class CreateCrisprs < ActiveRecord::Migration
  def change
    create_table :crisprs do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :crispr_construct, index: true, foreign_key: true
      t.references :donor_construct, index: true, foreign_key: true
      t.references :biosample, index: true, foreign_key: true
			t.text :description

      t.timestamps null: false
    end
		add_index :crisprs, :name, unique: true
  end
end
