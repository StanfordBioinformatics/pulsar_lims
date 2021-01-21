class AddDefaultsInPcr < ActiveRecord::Migration
  def change
    change_column_default :pcrs, :sanger_sequencing_success, false
  end
end
