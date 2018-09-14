class AddNameToImmunoblots < ActiveRecord::Migration
  def change
    add_column :immunoblots, :name, :string
  end
end
