class AddDefaultsInPcr < ActiveRecord::Migration
  def change
    change_column_default :pcrs, :success, false
  end
end
