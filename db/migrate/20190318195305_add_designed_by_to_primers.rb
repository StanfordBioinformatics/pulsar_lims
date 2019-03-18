class AddDesignedByToPrimers < ActiveRecord::Migration
  def change
    add_reference :primers, :designed_by, index: true
    add_foreign_key :primers, :users, column: :designed_by_id
  end
end
