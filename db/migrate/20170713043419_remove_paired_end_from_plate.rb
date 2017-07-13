class RemovePairedEndFromPlate < ActiveRecord::Migration
  def change
		remove_column :plates, :paired_end
  end
end
