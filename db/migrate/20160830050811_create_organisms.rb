class CreateOrganisms < ActiveRecord::Migration
  def change
    create_table :organisms do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
