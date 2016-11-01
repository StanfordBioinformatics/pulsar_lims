class AddUserToVendors < ActiveRecord::Migration
  def change
    add_reference :vendors, :user, index: true
    add_foreign_key :vendors, :users
  end
end
