class RenamePairedEndToDualIndexedInLibraries < ActiveRecord::Migration
  def change
    rename_column :libraries, :paired_end, :dual_indexed
  end
end
