class RemoveIndexOnNameInSequencingRequests < ActiveRecord::Migration
  def change
    remove_index :sequencing_requests, :name
  end
end
