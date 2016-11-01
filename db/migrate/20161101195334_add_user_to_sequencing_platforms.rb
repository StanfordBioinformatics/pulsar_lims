class AddUserToSequencingPlatforms < ActiveRecord::Migration
  def change
    add_reference :sequencing_platforms, :user, index: true
    add_foreign_key :sequencing_platforms, :users
  end
end
