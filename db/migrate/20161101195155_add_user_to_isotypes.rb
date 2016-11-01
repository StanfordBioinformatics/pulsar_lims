class AddUserToIsotypes < ActiveRecord::Migration
  def change
    add_reference :isotypes, :user, index: true
    add_foreign_key :isotypes, :users
  end
end
