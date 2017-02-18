class RanameEncodeAliaseInDonorToName < ActiveRecord::Migration
  def change
		rename_column :donors, :encode_alias, :name
  end
end
