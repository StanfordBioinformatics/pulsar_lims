class AddWildTypeInputToBiosampleReplicate < ActiveRecord::Migration
  def change
    add_column :biosample_replicates, :wild_type_input, :boolean, default: false
  end
end
