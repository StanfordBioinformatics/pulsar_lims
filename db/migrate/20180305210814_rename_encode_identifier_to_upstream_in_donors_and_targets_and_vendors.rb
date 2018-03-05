class RenameEncodeIdentifierToUpstreamInDonorsAndTargetsAndVendors < ActiveRecord::Migration
  def change
    rename_column :donors, :encode_identifier, :upstream
    rename_column :targets, :encode_identifier, :upstream
    rename_column :vendors, :encode_identifier, :upstream
  end
end
