class RenameHumanTargetToTarget < ActiveRecord::Migration
  def change
		rename_table :human_targets, :targets
  end
end
