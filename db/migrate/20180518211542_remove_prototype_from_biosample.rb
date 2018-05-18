class RemovePrototypeFromBiosample < ActiveRecord::Migration
  def change
    remove_column :biosamples, :prototype
  end
end
