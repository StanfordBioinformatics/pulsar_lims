class CreateJoinLibrariesSequencingRequests < ActiveRecord::Migration
  def change
    create_join_table :libraries, :sequencing_requests do |t|
			t.index :library_id
			t.index :sequencing_request_id
    end
  end
end
