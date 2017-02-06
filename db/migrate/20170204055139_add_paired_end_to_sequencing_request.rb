class AddPairedEndToSequencingRequest < ActiveRecord::Migration
  def change
    add_column :sequencing_requests, :paired_end, :boolean
  end
end
