class RemovePrimerStrFieldsFromPcrs < ActiveRecord::Migration
  def change
    remove_column :pcrs, :forward_primer
    remove_column :pcrs, :reverse_primer
  end
end
