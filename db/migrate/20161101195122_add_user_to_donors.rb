class AddUserToDonors < ActiveRecord::Migration
  def change
    add_reference :donors, :user, index: true
    add_foreign_key :donors, :users
  end
end
