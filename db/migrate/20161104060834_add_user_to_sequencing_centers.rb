class AddUserToSequencingCenters < ActiveRecord::Migration
  def change
    add_reference :sequencing_centers, :user, index: true
    add_foreign_key :sequencing_centers, :users
  end
end
