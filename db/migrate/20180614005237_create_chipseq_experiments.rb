class CreateChipseqExperiments < ActiveRecord::Migration
  def change
    create_table :chipseq_experiments do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :upstream_identifier
      t.references :target, index: true, foreign_key: true
      t.text :submitter_comments
      t.text :notes

      t.timestamps null: false
    end
  end
end
