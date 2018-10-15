class AddDefaultsInBiosample < ActiveRecord::Migration
  def change
    change_column_default :biosamples, :wild_type, false
    change_column_default :biosamples, :control, false
  end
end
