class AddUniprotkbToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :uniprotkb, :string
    add_index :targets, :uniprotkb, unique: true
  end
end
