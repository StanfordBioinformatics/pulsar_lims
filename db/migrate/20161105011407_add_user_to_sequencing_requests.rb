class AddUserToSequencingRequests < ActiveRecord::Migration
  def change
    add_reference :sequencing_requests, :user, index: true
    add_foreign_key :sequencing_requests, :users
  end
end
