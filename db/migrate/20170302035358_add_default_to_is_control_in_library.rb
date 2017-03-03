class AddDefaultToIsControlInLibrary < ActiveRecord::Migration
  def change
		change_column :libraries, :is_control, :boolean, :default => false
  end

end
