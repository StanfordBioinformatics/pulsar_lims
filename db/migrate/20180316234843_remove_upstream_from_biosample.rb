class RemoveUpstreamFromBiosample < ActiveRecord::Migration
  def change
    remove_column :biosamples, :upstream
  end
end
