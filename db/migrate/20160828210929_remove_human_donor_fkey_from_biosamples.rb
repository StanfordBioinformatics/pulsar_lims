class RemoveHumanDonorFkeyFromBiosamples < ActiveRecord::Migration
  def change
    remove_column :biosamples, :human_donor_id, :integer
  end
end
