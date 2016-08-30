class CreateIsotypes < ActiveRecord::Migration
  def change
    create_table :isotypes do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
