class AddIndexToNameInBiosample < ActiveRecord::Migration
  def change
		add_index :biosamples, :name, unique: true
  end
end
