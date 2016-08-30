class RemoveAntibodyPurificationsIdFromAntibody < ActiveRecord::Migration
  def change
		remove_column :antibodies, :antibody_purifications_id
  end
end
