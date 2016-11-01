class AddUserToBiosampleTypes < ActiveRecord::Migration
  def change
    add_reference :biosample_types, :user, index: true
    add_foreign_key :biosample_types, :users
  end
end
