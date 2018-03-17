class RemoveColumnUpstreamFromSequencingPlatform < ActiveRecord::Migration
  def change
    remove_column :sequencing_platforms, :upstream
  end
end
