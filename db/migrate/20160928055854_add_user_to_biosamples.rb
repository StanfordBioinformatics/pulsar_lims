class AddUserToBiosamples < ActiveRecord::Migration
  def change
    add_reference :biosamples, :user, index: true
    add_foreign_key :biosamples, :users
  end
end
