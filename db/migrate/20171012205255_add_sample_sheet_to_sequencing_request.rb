class AddSampleSheetToSequencingRequest < ActiveRecord::Migration
  def change
    add_column :sequencing_requests, :sample_sheet, :string
  end
end
