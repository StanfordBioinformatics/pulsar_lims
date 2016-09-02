class AddIndexToNameInLibrary < ActiveRecord::Migration
  def change
		add_index :libraries, :name, unique: true
  end
end
