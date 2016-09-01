class AddNameToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :name, :string
  end
end
