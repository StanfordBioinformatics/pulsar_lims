class RemoveCrisprModificationFromPcrs < ActiveRecord::Migration
  def change
    remove_column :pcrs, :crispr_modification_id
  end
end
