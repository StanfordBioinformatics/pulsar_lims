class RemoveVoltageFromAgaroseGels < ActiveRecord::Migration
  def change
    remove_column :agarose_gels, :voltage
  end
end
