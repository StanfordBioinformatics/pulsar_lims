class RemovePrototypeFromLibraries < ActiveRecord::Migration
  def change
    remove_column :libraries, :prototype
  end
end
