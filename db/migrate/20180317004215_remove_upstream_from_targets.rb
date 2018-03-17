class RemoveUpstreamFromTargets < ActiveRecord::Migration
  def change
    remove_column :targets, :upstream
  end
end
