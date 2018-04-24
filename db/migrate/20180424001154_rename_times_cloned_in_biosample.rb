class RenameTimesClonedInBiosample < ActiveRecord::Migration
  def change
    rename_column :biosamples, :times_cloned, :_times_cloned
  end
end
