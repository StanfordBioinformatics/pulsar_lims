class CreateImmunoblots < ActiveRecord::Migration
  def change
    create_table :immunoblots do |t|
      t.references :user, index: true, foreign_key: true
      t.references :agarose_gel, index: true, foreign_key: true
      t.date :date_performed
      t.text :submitter_comments
      t.text :notes

      t.timestamps null: false
    end
  end
end
