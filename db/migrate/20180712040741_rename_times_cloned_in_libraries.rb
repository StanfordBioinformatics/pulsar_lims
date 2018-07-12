class RenameTimesClonedInLibraries < ActiveRecord::Migration
  def change
    rename_column :libraries, :_times_cloned, :times_cloned
  end
end
