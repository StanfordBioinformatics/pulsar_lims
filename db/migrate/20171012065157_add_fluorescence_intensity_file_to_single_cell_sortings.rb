class AddFluorescenceIntensityFileToSingleCellSortings < ActiveRecord::Migration
  def change
    add_column :single_cell_sortings, :fluorescence_intensity_file, :string
  end
end
