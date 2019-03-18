class AddOrderedFromToPrimers < ActiveRecord::Migration
  def change
    add_reference :primers, :ordered_from, index: true
    add_foreign_key :primers, :vendors, column: :ordered_from_id
  end
end
