class AddColumnToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :control, :boolean
  end
end
