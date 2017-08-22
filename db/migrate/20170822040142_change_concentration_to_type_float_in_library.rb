class ChangeConcentrationToTypeFloatInLibrary < ActiveRecord::Migration
  def change
		change_column :libraries, :concentration, :float
  end
end
