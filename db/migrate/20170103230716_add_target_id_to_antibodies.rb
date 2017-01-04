class AddTargetIdToAntibodies < ActiveRecord::Migration
  def change
		add_reference :antibodies, :target, index: true
		add_foreign_key :antibodies, :targets
  end
end
