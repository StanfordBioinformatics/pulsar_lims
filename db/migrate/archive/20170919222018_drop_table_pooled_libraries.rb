class DropTablePooledLibraries < ActiveRecord::Migration
  def change
		drop_table :pooled_libraries
  end
end
