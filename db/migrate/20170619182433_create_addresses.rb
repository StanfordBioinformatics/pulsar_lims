class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.integer :postal_code
      t.string :country

      t.timestamps null: false
    end
  end
end
