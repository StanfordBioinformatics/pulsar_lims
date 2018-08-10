class RemoveIndexNameInLibraries < ActiveRecord::Migration
  def change
    remove_index :libraries, :name
  end
end
