class RenameTimesClonedInBiosamples < ActiveRecord::Migration
  def change
    rename_column :biosamples, :_times_cloned, :times_cloned
  end
end
