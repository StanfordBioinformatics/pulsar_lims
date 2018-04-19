class AddTubeLabelToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :tube_label, :string
  end
end
