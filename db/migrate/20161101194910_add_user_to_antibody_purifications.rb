class AddUserToAntibodyPurifications < ActiveRecord::Migration
  def change
    add_reference :antibody_purifications, :user, index: true
    add_foreign_key :antibody_purifications, :users
  end
end
