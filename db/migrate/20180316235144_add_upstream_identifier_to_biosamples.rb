class AddUpstreamIdentifierToBiosamples < ActiveRecord::Migration
  def change
    add_column :biosamples, :upstream_identifier, :string, unique: true
  end
end
