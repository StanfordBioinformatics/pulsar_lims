class RemoveNotesFromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :notes
  end
end
