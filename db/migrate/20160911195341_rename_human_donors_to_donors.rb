class RenameHumanDonorsToDonors < ActiveRecord::Migration
  def change
		rename_table :human_donors, :donors
  end
end
