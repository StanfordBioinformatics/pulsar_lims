class AddHumanTargetFkeyToAntibodies < ActiveRecord::Migration
  def change
    add_reference :antibodies, :human_target, index: true
    add_foreign_key :antibodies, :human_targets
  end
end
