class AddControlToBiosampleReplicate < ActiveRecord::Migration
  def change
    add_column :biosample_replicates, :control, :boolean, default: false
  end
end
