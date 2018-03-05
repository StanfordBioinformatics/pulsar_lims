class RenameColumnEncidInBiosamplesToUpstream < ActiveRecord::Migration
  def change
    rename_column :biosamples, :encid, :upstream
  end
end
