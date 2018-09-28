class RemoveSubmittedByAndDateSubmittedFromSequencingRequests < ActiveRecord::Migration
  def change
    remove_column :sequencing_requests, :submitted_by_id, :integer
    remove_column :sequencing_requests, :date_submitted, :integer
  end
end
