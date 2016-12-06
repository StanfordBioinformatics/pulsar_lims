class AddIndexToTargets < ActiveRecord::Migration
  def change
		add_index :targets, :encode_identifier, unique: true
		add_index :targets, :name, unique: true
  end
end
