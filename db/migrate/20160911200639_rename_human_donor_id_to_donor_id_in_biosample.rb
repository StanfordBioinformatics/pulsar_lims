class RenameHumanDonorIdToDonorIdInBiosample < ActiveRecord::Migration
  def change
		rename_column :biosamples, :human_donor_id, :donor_id
  end
end
