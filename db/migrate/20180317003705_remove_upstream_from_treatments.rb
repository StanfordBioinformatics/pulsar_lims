class RemoveUpstreamFromTreatments < ActiveRecord::Migration
  def change
    remove_column :treatments, :upstream
  end
end
