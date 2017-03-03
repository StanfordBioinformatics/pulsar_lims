class RenameColumnControlInLibrary < ActiveRecord::Migration
  def change
		rename_column(:libraries,:control,:is_control)
  end
end
