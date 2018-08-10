class AddAverageSizeToSequencingRequests < ActiveRecord::Migration
  def change
    add_column :sequencing_requests, :average_size, :string
  end
end
