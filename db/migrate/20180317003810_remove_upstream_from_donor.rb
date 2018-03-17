class RemoveUpstreamFromDonor < ActiveRecord::Migration
  def change
    remove_column :donors, :upstream
  end
end
