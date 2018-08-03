class AddTypeToUnits < ActiveRecord::Migration
  def change
    add_column :units, :type, :string
  end
end
