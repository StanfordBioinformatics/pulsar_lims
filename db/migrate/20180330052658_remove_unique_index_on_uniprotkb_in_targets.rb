class RemoveUniqueIndexOnUniprotkbInTargets < ActiveRecord::Migration
  def change
    remove_index :targets, :uniprotkb
  end
end
