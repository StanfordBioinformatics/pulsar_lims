class AddIndexToNameInAntibody < ActiveRecord::Migration
  def change
		add_index :antibodies, :name, unique: true
  end
end
