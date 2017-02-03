class CreateSequencingResults < ActiveRecord::Migration
  def change
    create_table :sequencing_results do |t|
      t.references :user, index: true
      t.references :sequencing_request, index: true
			t.references :report, index: true
      t.string :run_name
      t.integer :lane
      t.text :comment

      t.timestamps null: false
    end
    add_foreign_key :sequencing_results, :users
    add_foreign_key :sequencing_results, :sequencing_requests
    add_foreign_key :sequencing_results, :documents, column: :report_id
  end
end
