class AddUpstreamIdentifierToAtacseq < ActiveRecord::Migration
  def change
    add_column :atacseqs, :upstream_identifier, :string, unique: true
  end
end
