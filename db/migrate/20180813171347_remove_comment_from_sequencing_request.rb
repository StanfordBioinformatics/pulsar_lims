class RemoveCommentFromSequencingRequest < ActiveRecord::Migration
  def change
    remove_column :sequencing_requests, :comment
  end
end
