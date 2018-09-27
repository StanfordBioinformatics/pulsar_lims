class AddStatusToSequencingRuns < ActiveRecord::Migration
  def change
    add_column :sequencing_runs, :status, :string
    add_column :sequencing_runs, :date_submitted, :date
    add_reference :sequencing_runs, :submitted_by, index: true
    add_foreign_key :sequencing_runs, :users, column: :submitted_by_id
  end
end
