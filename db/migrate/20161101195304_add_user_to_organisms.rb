class AddUserToOrganisms < ActiveRecord::Migration
  def change
    add_reference :organisms, :user, index: true
    add_foreign_key :organisms, :users
  end
end
