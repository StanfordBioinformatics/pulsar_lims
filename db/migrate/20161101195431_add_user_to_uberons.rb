class AddUserToUberons < ActiveRecord::Migration
  def change
    add_reference :uberons, :user, index: true
    add_foreign_key :uberons, :users
  end
end
