class RemovePcrIdFromGels < ActiveRecord::Migration
  def change
    remove_column :gels, :pcr_id
  end
end
