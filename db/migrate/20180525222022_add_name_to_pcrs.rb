class AddNameToPcrs < ActiveRecord::Migration
  def change
    add_column :pcrs, :name, :string
  end
end
