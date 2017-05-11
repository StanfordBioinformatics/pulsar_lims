class AddControlToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :control, :boolean
  end
end
