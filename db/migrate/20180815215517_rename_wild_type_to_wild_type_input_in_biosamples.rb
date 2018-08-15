class RenameWildTypeToWildTypeInputInBiosamples < ActiveRecord::Migration
  def change
    rename_column :biosamples, :wild_type, :wild_type_control
  end
end
