class RenameStrandSpecificityToStrandSpecificInLibrary < ActiveRecord::Migration
  def change
		rename_column :libraries, :strand_specificity, :strand_specific
  end
end
