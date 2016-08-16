class CreateBiosampleTypes < ActiveRecord::Migration
  def change
    create_table :biosample_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
