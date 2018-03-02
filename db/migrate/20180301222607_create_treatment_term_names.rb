class CreateTreatmentTermNames < ActiveRecord::Migration
  def change
    create_table :treatment_term_names do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :accession
      t.text :description

      t.timestamps null: false
    end
  end
end
