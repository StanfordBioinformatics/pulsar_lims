class AddUniqueIndexToLibrarySequencingRequestsJoinTable < ActiveRecord::Migration
  def change
		add_index :libraries_sequencing_requests, [:library_id, :sequencing_request_id], unique: true, name: "lib_sreq_index"
  end
end
