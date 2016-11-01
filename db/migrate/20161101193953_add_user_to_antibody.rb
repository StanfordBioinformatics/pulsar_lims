class AddUserToAntibody < ActiveRecord::Migration
  def change
    add_reference :antibodies, :user, index: true
    add_foreign_key :antibodies, :users
  end
end
