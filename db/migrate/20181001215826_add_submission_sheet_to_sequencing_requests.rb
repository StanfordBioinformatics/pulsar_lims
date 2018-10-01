class AddSubmissionSheetToSequencingRequests < ActiveRecord::Migration
  def change
    add_column :sequencing_requests, :submission_sheet, :string
  end
end
