class AddCellsDiedAfterTransfectionToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :cells_died_after_transfection, :boolean
  end
end
