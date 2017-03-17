class CreateChromosomes < ActiveRecord::Migration
  def change
    create_table :chromosomes do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :reference_genome, index: true, foreign_key: true

      t.timestamps null: false
    end
		add_index :chromosomes, :name, unique: true
  end
end
