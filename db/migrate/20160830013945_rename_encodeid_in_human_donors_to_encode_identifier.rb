class RenameEncodeidInHumanDonorsToEncodeIdentifier < ActiveRecord::Migration
  def change
		rename_column :human_donors, :encode_id, :encode_identifier
  end
end
