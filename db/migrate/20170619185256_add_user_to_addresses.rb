class AddUserToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :user, index: true, foreign_key: true
  end
end
