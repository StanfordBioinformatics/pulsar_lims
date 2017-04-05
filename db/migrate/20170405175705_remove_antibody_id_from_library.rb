class RemoveAntibodyIdFromLibrary < ActiveRecord::Migration
  def change
		remove_column :libraries, :antibody_id
  end
end
