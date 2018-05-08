class AddDonorCellLineAndDbsnpsToDonorConstructs < ActiveRecord::Migration
  def change
    add_column :donor_constructs, :donor_cell_line, :string
    add_column :donor_constructs, :known_snps, :string
  end
end
