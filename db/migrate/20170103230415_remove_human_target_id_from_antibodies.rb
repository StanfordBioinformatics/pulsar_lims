class RemoveHumanTargetIdFromAntibodies< ActiveRecord::Migration
  def change
		remove_column :antibodies, :human_target_id, :string
  end
end
