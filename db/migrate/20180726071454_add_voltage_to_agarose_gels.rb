class AddVoltageToAgaroseGels < ActiveRecord::Migration
  def change
    add_column :agarose_gels, :voltage, :float
  end
end
