class AddFromAndToToShipping < ActiveRecord::Migration
  def change
    add_reference :shippings, :from, index: true
    add_reference :shippings, :to, index: true
    add_foreign_key :shippings, :addresses, column: :from_id
    add_foreign_key :shippings, :addresses, column: :to_id
  end
end
