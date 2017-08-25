class AddPlatedToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :plated, :boolean, default: false
  end
end
