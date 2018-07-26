class CreateAgaroseGels < ActiveRecord::Migration
  def change
    create_table :agarose_gels do |t|
      t.string :percent_agarose
      t.string :voltage
      t.date :run_date
      t.text :notes
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
