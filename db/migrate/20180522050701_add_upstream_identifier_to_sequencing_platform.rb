class AddUpstreamIdentifierToSequencingPlatform < ActiveRecord::Migration
  def change
    add_column :sequencing_platforms, :upstream_identifier, :string
  end
end
