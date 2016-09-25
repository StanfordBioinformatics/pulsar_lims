class AddUserToLibraries < ActiveRecord::Migration
  def change
    add_reference :libraries, :user, index: true
    add_foreign_key :libraries, :users
  end
end
