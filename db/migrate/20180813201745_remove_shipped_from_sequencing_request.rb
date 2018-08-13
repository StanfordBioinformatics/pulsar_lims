class RemoveShippedFromSequencingRequest < ActiveRecord::Migration
  def change
    remove_column :sequencing_requests, :shipped
  end
end
