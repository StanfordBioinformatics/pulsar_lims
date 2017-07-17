class CreateJoinTablePlatesSequencingRequests < ActiveRecord::Migration
  def change
    create_join_table :plates, :sequencing_requests do |t|
      #t.index [:plate_id, :sequencing_request_id]
      #t.index [:sequencing_request_id, :plate_id]
    end
		add_index :plates_sequencing_requests, [:plate_id, :sequencing_request_id], name: "plate_sequencing_request"
		add_index :plates_sequencing_requests, [:sequencing_request_id, :plate_id], name: "sequencing_request_plate"
  end
end
