class AddNameToBiosampleReplicate < ActiveRecord::Migration
  def change
    add_column :biosample_replicates, :name, :string
    add_index :biosample_replicates, :name, unique: true
  end
end
