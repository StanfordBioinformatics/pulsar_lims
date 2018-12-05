class AddUpstreamIdentifiersToSequencingResult < ActiveRecord::Migration
  def change
    add_column :sequencing_results, :read1_upstream_identifier, :string
    add_column :sequencing_results, :read2_upstream_identifier, :string
  end
end
