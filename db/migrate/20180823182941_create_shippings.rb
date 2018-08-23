class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.references :user, index: true, foreign_key: true
      t.string :carrier
      t.string :tracking_code
      t.date :date_shipped
      t.boolean :received

      t.timestamps null: false
    end
  end
end
