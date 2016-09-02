class CreateExperimentTypes < ActiveRecord::Migration
  def change
    create_table :experiment_types do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
