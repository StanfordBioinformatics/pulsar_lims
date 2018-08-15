class RenameWildTypeControlToWildTypeInBiosample < ActiveRecord::Migration
  def change
    rename_column :biosamples, :wild_type_control, :wild_type
  end
end
