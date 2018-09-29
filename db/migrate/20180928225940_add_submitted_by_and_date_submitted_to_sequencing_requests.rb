class AddSubmittedByAndDateSubmittedToSequencingRequests < ActiveRecord::Migration
  def change
    add_reference :sequencing_requests, :submitted_by, index: true
    add_column :sequencing_requests, :date_submitted, :date
    add_foreign_key :sequencing_requests, :users, column: :submitted_by_id 
  end
end
