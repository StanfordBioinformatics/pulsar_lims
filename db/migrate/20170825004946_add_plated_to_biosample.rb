class AddPlatedToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :plated, :boolean, default: false
  end
end
