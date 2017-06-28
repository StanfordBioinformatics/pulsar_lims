class AddPrototypeToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :prototype, :boolean, default: false
  end
end
