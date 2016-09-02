class AddIndexToNameInDocument < ActiveRecord::Migration
  def change
		add_index :documents, :name, unique: true
  end
end
