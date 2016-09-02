class AddNameToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :name, :string, index: true
  end
end
