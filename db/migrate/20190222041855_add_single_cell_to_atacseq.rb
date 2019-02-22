class AddSingleCellToAtacseq < ActiveRecord::Migration
  def change
    add_column :atacseqs, :single_cell, :boolean, default: false
  end
end
